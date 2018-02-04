# frozen_string_literal: true

class Syscase
  class Argument
    # file descriptor argument
    class FileDescriptor < self
      def call(buffer, _extra)
        pack_value_with(buffer, '!CS>', 5)
      end
    end
  end
end
