# frozen_string_literal: true

require 'digest'
require 'base64'

# rubocop:disable Metrics/ClassLength
class Syscase
  class Web
    # Import of example result data to database
    class ExampleImport
      def initialize(hash)
        @result = hash.fetch(:result)
        @input_file = hash.fetch(:input_file)
        @path_file = hash.fetch(:path_file)
        @secure_log_file = hash.fetch(:secure_log_file)
        @normal_log_file = hash.fetch(:normal_log_file)
        @remove = hash.fetch(:remove, false)
        setup
      end

      def call
        Syscase::Web.db.container.gateways[:default].transaction do |_t|
          import
          clean
        end

        self
      end

      private

      def setup
        @input = Base64.encode64(IO.binread(@input_file))
        @path = IO.read(@path_file).strip
        @secure_log = Base64.encode64(IO.read(@secure_log_file))
        @normal_log = Base64.encode64(IO.read(@normal_log_file))
        @example = example_model
      end

      def example_model
        Syscase::Web::Model::ExampleWithPaths.new(
          input:      @input,
          result:     @result,
          sha256:     Digest::SHA256.hexdigest(@path),
          path:       @path,
          time:       Time.now,
          secure_log: @secure_log,
          normal_log: @normal_log,
          paths:      example_paths
        )
      end

      def example_paths
        @path.split("\n").each_with_index.map do |data, index|
          start_addr, end_addr, address, level, is_secure = data.split(',')
          Syscase::Web::Model::Path.new(index:   index,
                                        address: address.to_i(16),
                                        start:   start_addr.to_i(16),
                                        end:     end_addr.to_i(16),
                                        level:   level.to_i,
                                        is_secure: !is_secure.to_i.zero?)
        end
      end

      def import
        puts "Lookup hash #{@example.sha256}"
        equal_examples = examples.by_hash(@example.sha256).to_a
        if !equal_examples.empty?
          import_with_existing_hash(equal_examples)
        else
          import_with_new_hash
        end
        puts 'Import finished'
      end

      def import_with_existing_hash(equal_examples)
        id = equal_examples.first[:id]
        puts "Found hash: #{@example.sha256}"
        puts "Increment example count for #{id}"
        create_example_count(id)
      end

      def import_with_new_hash
        puts "Hash not found: #{@example.sha256}"
        example_id = create_example[:id]

        create_paths(example_id)
        create_example_count(example_id)
      end

      def clean
        return unless @remove
        # If remove is true, we consider input files as exclusivly queued for
        # import.
        puts "Remove input file: #{@input_file}"
        FileUtils.rm(@input_file)
        puts "Remove path file: #{@input_file}"
        FileUtils.rm(@path_file)
        puts "Remove secure log file: #{@secure_log_file}"
        FileUtils.rm(@secure_log_file)
        puts "Remove normal log file: #{@normal_log_file}"
        FileUtils.rm(@normal_log_file)
        puts 'Clean up finished'
      end

      def create_example
        examples.create(@example.to_h)
      end

      def create_example_count(example_id)
        example_counts.create(example_count_from(example_id).to_h)
      end

      def example_count_from(example_id)
        Syscase::Web::Model::ExampleCount.new(
          example: example_id,
          count:   1
        )
      end

      def create_paths(example_id)
        @example.paths.each do |path|
          create_path(path, example_id)
        end
      end

      def create_path(path, example_id)
        paths.create(path.to_h.merge(example: example_id))
      end

      REPO = Syscase::Web::Persistence::Repositories

      def examples
        @examples ||= Syscase::Web.db.repository(REPO::Examples)
      end

      def example_counts
        @example_counts ||= Syscase::Web.db.repository(REPO::ExampleCounts)
      end

      def paths
        @paths ||= Syscase::Web.db.repository(REPO::Paths)
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
