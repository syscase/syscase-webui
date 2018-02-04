# frozen_string_literal: true

class Syscase
  class Argument
    # Ref argument
    class Ref < self
      def initialize(nc, na)
        @nc = nc
        @na = na
      end

      def call(buffer, _extra)
        pack_with(buffer, '!CCC', 10, @nc, @na)
      end
    end
  end
end
