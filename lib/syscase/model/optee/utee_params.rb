# frozen_string_literal: true

class Syscase
  class Model
    # OPTEE model
    class OPTEE
      # UTEEParams model
      class UTEEParams < Syscase::Model::WithDefaults
        attribute :types, INTEGER.default(0x0)
        attribute :vals_0, INTEGER.default(0x0)
        attribute :vals_1, INTEGER.default(0x0)
        attribute :vals_2, INTEGER.default(0x0)
        attribute :vals_3, INTEGER.default(0x0)
        attribute :vals_4, INTEGER.default(0x0)
        attribute :vals_5, INTEGER.default(0x0)
        attribute :vals_6, INTEGER.default(0x0)
        attribute :vals_7, INTEGER.default(0x0)

        def pack(buffer)
          buffer.pack('Q>', types)
          (0..7).each do |index|
            buffer.pack('Q>', __send__("vals_#{index}".to_sym))
          end
        end
      end
    end
  end
end
