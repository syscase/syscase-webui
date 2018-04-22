# frozen_string_literal: true

class Syscase
  class Model
    # OPTEE model
    class OPTEE
      # Time model
      class Time < Syscase::Model
        constructor_type :schema

        attribute :seconds, Syscase::Types::Strict::Int.default(0x0)
        attribute :millis, Syscase::Types::Strict::Int.default(0x0)

        def pack(buffer)
          to_h.each_value do |value|
            buffer.pack('L>', value)
          end
        end
      end
    end
  end
end
