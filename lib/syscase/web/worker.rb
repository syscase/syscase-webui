# frozen_string_literal: true

require 'logger'
require 'time'

class Syscase
  class Web
    # Worker
    class Worker
      DEFAULT_WAIT_TIME = 1
      TAR_ROOT = File.join(Syscase::Web.root, 'import').freeze
      TAR_JOB_LIMIT = 10_000
      TAR_CMD = ['tar', '--append', '--xz', '--verbose', '--remove-files',
                 '--file'].freeze
      FILE_REGEX = %r{.*/([^/]+)-((?:[\h]+-){4}[\h]+)-result-([a-z]+)\.scov$}

      def initialize(working_dir, remove = false)
        @working_dir = working_dir
        @remove = remove
        @uuid = SecureRandom.uuid
        setup_logging
        setup_tar
      end

      def call
        loop do
          wait_for_jobs(DEFAULT_WAIT_TIME) until jobs?
          import
        end
      end

      def import
        files.each do |file|
          @logger.info "Import: #{file}"
          import_file(file)
        end
        self
      end

      private

      def setup_logging
        @log_file = ENV.fetch('IMPORT_LOG_FILE', false)

        if @log_file
          @logger = Logger.new(@log_file)
          $stdout.reopen logger.instance_variable_get(:@logdev).dev
          $stderr.reopen logger.instance_variable_get(:@logdev).dev
        else
          @logger = Logger.new($stdout)
        end
      end

      def setup_tar
        @tar_root = File.join(TAR_ROOT, @uuid)
        puts "tar output directory: #{@tar_root}" if @remove
        rotate_tar
      end

      def rotate_tar
        @tar = File.join(@tar_root,
                         "#{Time.now.strftime('%Y-%m-%d-%H%M%S-%L%Z')}.tar.xz")
        @tar_count = 0
      end

      def wait_for_jobs(s)
        @logger.info "Wait #{s}s for jobs"
        sleep s
      end

      def jobs?
        !files.empty?
      end

      def files
        Dir["#{@working_dir}/**-result-*.scov"].tap do |dirs|
          @logger.info "Found #{dirs.size} job(s)"
        end
      end

      def import_file(file)
        import_example(result:          result_for(file),
                       time:            time_for(file),
                       input_file:      file_for(file, 'scase'),
                       path_file:       file,
                       secure_log_file: file_for(file, 'secure.log'),
                       normal_log_file: file_for(file, 'normal.log'),
                       remove:          false)
      rescue StandardError => e
        handle_error(e)
        self
      end

      def import_example(hash)
        Syscase::Web::ExampleImport.new(hash).call
        return unless @remove

        rotate_tar if @tar_count >= TAR_JOB_LIMIT
        tar_files(files_to_tar(hash))
        @tar_count += 1
      end

      def files_to_tar(hash)
        hash.select { |key| key.to_s.end_with?('_file') }
            .values
      end

      def tar_files(files)
        Kernel.system(*(TAR_CMD + [@tar] + files))
      end

      def result_for(file)
        file[FILE_REGEX, 3]
      end

      def time_for(file)
        Time.strptime(file[FILE_REGEX, 1], '%Y-%m-%d-%H%M%S-%Z')
      end

      def file_for(file, suffix)
        file.sub(/(.*\.)scov$/, "\\1#{suffix}")
      end

      def handle_error(e)
        @logger.error 'Import failed:'
        @logger.error  e.message
        @logger.error  e.backtrace.inspect
      end
    end
  end
end
