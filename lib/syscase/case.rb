# frozen_string_literal: true

class Syscase
  # Case
  class Case
    def initialize(example)
      @example = example
    end

    def to_s
      ascii_string
    end

    private

    def ascii_string
      [fuzzing_mode, @example].join.force_encoding(Encoding::ASCII)
    end

    def fuzzing_mode
      Syscase::Buffer.new.pack('!C', @example.fuzzing_mode)
    end
  end
end
