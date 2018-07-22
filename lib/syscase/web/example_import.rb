# frozen_string_literal: true

require 'digest'
require 'base64'

class Syscase
  class Web
    # Import of example result data to database
    class ExampleImport
      def initialize(result, input_file, path_file, remove = false)
        @result = result
        @input_file = input_file
        @path_file = path_file
        @remove = remove
        @input = Base64.encode64(IO.binread(@input_file))
        @path = IO.read(@path_file).strip
        @example = example_model
      end

      def call
        Syscase::Web.db.container.gateways[:default].transaction do |_t|
          import
          clean
        end

        self
      end

      private

      def example_model
        Syscase::Web::Model::ExampleWithPaths.new(
          input: @input,
          result: @result,
          sha256:  Digest::SHA256.hexdigest(@path),
          path:  @path,
          time:  Time.now,
          paths: example_paths
        )
      end

      def example_paths
        @path.split("\n").each_with_index.map do |address, index|
          Syscase::Web::Model::Path.new(
            index: index,
            address: address.to_i(16)
          )
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
          count: 1
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