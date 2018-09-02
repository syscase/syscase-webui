# frozen_string_literal: true

require 'logger'

class Syscase
  class Web
    # Import of compressed xz files
    class ArchiveImport
      DEFAULT_WORKING_ROOT = File.join(Syscase::Web.root, 'import').freeze

      def initialize(import_dir, working_root = DEFAULT_WORKING_ROOT)
        @import_dir = import_dir
        @working_root = working_root
        @uuid = SecureRandom.uuid
      end

      def call
        FileUtils.mkdir(working_dir)
        import
        FileUtils.rmdir(working_dir)
      end

      private

      def import
        files.each do |file|
          puts "Import: #{file}"
          import_file(file)
        end
        self
      end

      def working_dir
        @working_dir ||= File.join(@working_root, @uuid)
      end

      def files
        Dir["#{@import_dir}/*.xz"].sort.tap do |xzs|
          puts "Found #{xzs.size} xz file(s)"
        end
      end

      def import_file(file)
        puts "Extract '#{file}' to '#{working_dir}'"
        `tar xJf "#{file}" --xform="s#^.+/##x" --directory="#{working_dir}"`
        Worker.new(working_dir, true).import
      end
    end
  end
end
