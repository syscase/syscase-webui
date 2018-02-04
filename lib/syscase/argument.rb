# frozen_string_literal: true

class Syscase
  # Argument
  class Argument
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def call(_buffer, _extra)
      raise_not_implemented 'Argument#call(buffer, extra)'
    end

    def raise_not_implemented(method)
      raise NotImplementedError, "Override #{method}!"
    end

    private

    def pack_value_with(buffer, format, *values)
      pack_with(buffer, format, *values, @value)
    end

    def pack_with(buffer, format, *values)
      buffer.pack(format, *values)

      self
    end
  end
end
