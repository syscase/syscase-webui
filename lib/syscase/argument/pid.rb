# frozen_string_literal: true

class Syscase
  class Argument
    # Pid argument
    class Pid < self
      def call(buffer, _extra)
        pack_value_with(buffer, '!CC', 9)
      end
    end
  end
end
