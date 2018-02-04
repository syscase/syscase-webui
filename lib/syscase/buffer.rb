# frozen_string_literal: true

class Syscase
  # Buffer
  class Buffer
    def initialize(buffer = [])
      @buffer = buffer
    end

    def add(value)
      @buffer << value
    end

    def pack(format, *args)
      add(args.pack(format))

      self
    end

    def to_s
      @buffer.join.force_encoding(Encoding::ASCII)
    end
  end
end
