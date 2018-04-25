# frozen_string_literal: true

class Syscase
  # Case builder
  class CaseBuilder
    attr_reader :values, :cases

    def initialize(*values)
      @values = values
      @cases = []
    end

    def call
      @cases = @values.map do |value|
        case_for(value)
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
      @cases.join(Syscase::CASE_DELIMITER).force_encoding(Encoding::ASCII)
    end

    def case_for(value)
      return value if value.is_a?(Syscase::Case)

      Syscase::Case.new(value)
    end
  end
end
