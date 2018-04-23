# frozen_string_literal: true

class Syscase
  class Model
    # OPTEE model
    class OPTEE
      # UUID model
      class UUID < Syscase::Model
        constructor_type :schema

        attribute :time_low, Syscase::Types::Strict::Int.default(0x0)
        attribute :time_mid, Syscase::Types::Strict::Int.default(0x0)
        attribute :time_hi_and_version, Syscase::Types::Strict::Int.default(0x0)
        attribute :csan_0, Syscase::Types::Strict::Int.default(0x0)
        attribute :csan_1, Syscase::Types::Strict::Int.default(0x0)
        attribute :csan_2, Syscase::Types::Strict::Int.default(0x0)
        attribute :csan_3, Syscase::Types::Strict::Int.default(0x0)
        attribute :csan_4, Syscase::Types::Strict::Int.default(0x0)
        attribute :csan_5, Syscase::Types::Strict::Int.default(0x0)
        attribute :csan_6, Syscase::Types::Strict::Int.default(0x0)
        attribute :csan_7, Syscase::Types::Strict::Int.default(0x0)

        def pack(buffer)
          buffer.pack('L>', time_low)
          buffer.pack('S>', time_mid)
          buffer.pack('S>', time_hi_and_version)
          (0..7).each do |index|
            buffer.pack('!C', __send__("csan_#{index}".to_sym))
          end
        end
      end
    end
  end
end
