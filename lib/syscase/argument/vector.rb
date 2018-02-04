# frozen_string_literal: true

class Syscase
  class Argument
    # Vector argument
    class Vector < self
      # Vector size error
      class SizeError < ArgumentError
        def self.message(size)
          "Size (#{size}) of vector has to be smaller than 256!"
        end
      end

      attr_reader :values

      def initialize(*values)
        @values = values
        size = values.size
        raise SizeError, SizeError.message(size) if size >= 256
      end

      def call(buffer, extra)
        pack_with(buffer, '!CC', identifier, values.size)
        call_values(values, buffer, extra)
      end

      private

      def identifier
        raise_not_implemented 'Vector#identifier'
      end

      def call_values(values, buffer, extra)
        Syscase::ArgumentBuilder.new(values, buffer, extra).call

        self
      end
    end
  end
end
