# frozen_string_literal: true

class Syscase
  class Examples
    # Extended Examples
    class Extended < self
      attr_reader :strings, :input_path, :input

      def initialize(input_path, output_path)
        super(output_path)
        @input_path = input_path
        @input = IO.read(input_path)

        @examples = {}
        @strings = []
      end

      def describe
        create_examples if @examples.empty?
        @examples
      end

      def map
        @map ||= example_map
      end

      def tests
        @tests ||= product_hash(map)
      end

      def default
        @default ||= example_default
      end

      def range
        @range ||= example_range
      end

      def example_class
        raise NotImplementedError, 'Override Extended#example_class!'
      end

      private

      def example_map
        raise NotImplementedError, 'Override Extended#example_map!'
      end

      def example_default
        raise NotImplementedError, 'Override Extended#example_default!'
      end

      def example_range
        raise NotImplementedError, 'Override Extended#example_range!'
      end

      def product_hash(hash)
        map_product(product_of(hash.values), hash.keys)
      end

      def map_product(product, keys)
        product.map { |p| Hash[keys.zip p] }
      end

      def product_of(values)
        values[0].product(*values[1..-1])
      end

      def create_examples
        range.each do |call|
          @index = 0
          each_line(call)
        end
      end

      def each_line(call)
        @input.each_line do |line|
          each_test(line.chomp, call)
        end
      end

      def each_test(line, call)
        tests.each do |test|
          add_example(line, call, test)
        end
      end

      def add_example(line, call, test)
        ex = instance_for(line, call, test)
        add_unique_example_only(ex, ex.to_s)
      end

      def add_unique_example_only(ex, s)
        add_unique_example(ex, s) if unique_example?(s)

        self
      end

      def unique_example?(s)
        !@strings.include?(Syscase.ascii(s))
      end

      def add_unique_example(ex, s)
        @examples[ex.name.to_sym] = ex
        @strings << Syscase.ascii(s)
        @index += 1

        self
      end

      def instance_for(line, call, test)
        create_class
          .new(name_for(call, @index), path)
          .with([parse_line(line, call, test)])
      end

      def name_for(call, index)
        format('call%<call>03d-%<index>d', call: call, index: index)
      end

      def create_class
        @klass ||= Class.new(example_class)
      end

      def parse_line(line, call, test)
        line.split(',').each_with_object([call]) do |arg, args|
          args << parse_argument(arg.strip, test)
        end
      end

      def parse_argument(arg, test)
        test.fetch(arg.to_sym, default)
      end
    end
  end
end
