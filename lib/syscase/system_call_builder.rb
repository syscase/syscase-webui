# frozen_string_literal: true

class Syscase
  # System call builder
  class SystemCallBuilder
    attr_reader :values, :calls

    def initialize(*values)
      @values = values
      @calls = []
    end

    def call
      @calls = @values.map do |value|
        call_for(value)
      end

      self
    end

    def to_s
      ascii_string
    end

    def write(filename)
      IO.write(filename, to_s)
    end

    private

    def ascii_string
      call
      @calls.join(Syscase::CALL_DELIMITER).force_encoding(Encoding::ASCII)
    end

    def call_for(value)
      return value if value.is_a?(Syscase::SystemCall)

      Syscase::SystemCall.new(*value)
    end
  end
end
