# frozen_string_literal: true

class Syscase
  class Argument
    # Length argument
    class Length < self
      def initialize; end

      def call(buffer, _extra)
        pack_with(buffer, '!C', 3)
      end
    end
  end
end
