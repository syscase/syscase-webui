# frozen_string_literal: true

require 'logger'

class Syscase
  class Web
    # Worker
    class Worker
      DEFAULT_WAIT_TIME = 1

      def initialize(working_dir, remove = false)
        @working_dir = working_dir
        @remove = remove

        @log_file = ENV.fetch('IMPORT_LOG_FILE', false)

        if @log_file
          @logger = Logger.new(@log_file)
          $stdout.reopen logger.instance_variable_get(:@logdev).dev
          $stderr.reopen logger.instance_variable_get(:@logdev).dev
        else
          @logger = Logger.new($stdout)
        end
      end

      def call
        loop do
          wait_for_jobs(DEFAULT_WAIT_TIME) until jobs?

          begin
            import
          rescue StandardError => e
            handle_error(e)
          end
        end
      end

      private

      def wait_for_jobs(s)
        @logger.info "Wait #{s}s for jobs"
        sleep s
      end

      def jobs?
        !files.empty?
      end

      def import
        files.each do |file|
          @logger.info "Import: #{file}"
          import_file(file)
        end
      end

      def files
        Dir["#{@working_dir}/**-result-*.scov"].tap do |dirs|
          @logger.info "Found #{dirs.size} job(s)"
        end
      end

      def import_file(file)
        Syscase::Web::ExampleImport.new(
          result_for(file),
          input_file_for(file),
          file,
          @remove
        ).call
      end

      def result_for(file)
        file[/.*-result-([a-z]+)\.scov$/, 1]
      end

      def input_file_for(file)
        file.sub(/(.*\.)scov$/, '\1scase')
      end

      def handle_error(e)
        @logger.error 'Import failed:'
        @logger.error  e.message
        @logger.error  e.backtrace.inspect
      end
    end
  end
end
