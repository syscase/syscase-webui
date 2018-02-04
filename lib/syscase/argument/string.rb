# frozen_string_literal: true

class Syscase
  class Argument
    # String argument
    class String < self
      def call(buffer, extra)
        type(identifier, buffer, extra)
      end

      private

      def type(type, buffer, extra)
        extra.add(Syscase::BUFFER_DELIMITER)
        extra.add(@value)

        pack_with(buffer, '!C', type)
      end

      def identifier
        2
      end
    end
  end
end
