# frozen_string_literal: true

class Syscase
  class Argument
    # Allocation argument
    class Alloc < self
      def call(buffer, _extra)
        pack_value_with(buffer, '!CN', 1)
      end
    end
  end
end
