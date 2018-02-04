# frozen_string_literal: true

class Syscase
  class Argument
    # System call number argument
    class SystemCallNumber < self
      def call(buffer, _extra)
        pack_value_with(buffer, '!S>')
      end
    end
  end
end
