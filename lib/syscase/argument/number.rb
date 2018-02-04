# frozen_string_literal: true

class Syscase
  class Argument
    # Number argument
    class Number < self
      def call(buffer, _extra)
        pack_value_with(buffer.pack('!C', 0), 'Q>')
      end
    end
  end
end
