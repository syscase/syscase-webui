# frozen_string_literal: true

class Syscase
  # Argument Builder
  class ArgumentBuilder
    # Unsupported Type Error
    class UnsupportedTypeError < ArgumentError
      def self.message(value)
        "Type '#{value.class}' of value '#{value.inspect}' not supported!"
      end
    end

    attr_reader :values, :buffer, :extra

    def initialize(values, buffer = Buffer.new, extra = Buffer.new)
      @values = values
      @buffer = buffer
      @extra = extra
    end

    def call
      @values.each do |value|
        argument_for(value).call(buffer, extra)
      end

      self
    end

    def to_s
      ascii_string
    end

    private

    def ascii_string
      call
      combine_buffers.force_encoding(Encoding::ASCII)
    end

    def combine_buffers
      buffer.to_s + extra.to_s
    end

    CLASS_MAP = {
      ::String  => Syscase::Argument::String::Z,
      ::Integer => Syscase::Argument::Number
    }.freeze

    def argument_for(value)
      return value if value.is_a?(Argument)
      class_for(value).new(value)
    end

    def class_for(value)
      klass = first_class_for(value)
      return klass unless klass.nil?

      raise UnsupportedTypeError, UnsupportedTypeError.message(value)
    end

    def first_class_for(value)
      CLASS_MAP
        .select { |type, _klass| value.is_a?(type) }
        .values
        .first
    end
  end
end
