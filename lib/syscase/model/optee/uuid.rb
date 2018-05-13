# frozen_string_literal: true

class Syscase
  class Model
    # OPTEE model
    class OPTEE
      # UUID model
      class UUID < Syscase::Model::WithDefaults
        attribute :time_low, INTEGER.default(0x0)
        attribute :time_mid, INTEGER.default(0x0)
        attribute :time_hi_and_version, INTEGER.default(0x0)
        attribute :csan_0, INTEGER.default(0x0)
        attribute :csan_1, INTEGER.default(0x0)
        attribute :csan_2, INTEGER.default(0x0)
        attribute :csan_3, INTEGER.default(0x0)
        attribute :csan_4, INTEGER.default(0x0)
        attribute :csan_5, INTEGER.default(0x0)
        attribute :csan_6, INTEGER.default(0x0)
        attribute :csan_7, INTEGER.default(0x0)

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
