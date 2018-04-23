# frozen_string_literal: true

class Syscase
  class Model
    # OPTEE model
    class OPTEE
      # UTEEParams model
      class UTEEParams < Syscase::Model
        constructor_type :schema

        attribute :types, Syscase::Types::Strict::Int.default(0x0)
        attribute :vals_0, Syscase::Types::Strict::Int.default(0x0)
        attribute :vals_1, Syscase::Types::Strict::Int.default(0x0)
        attribute :vals_2, Syscase::Types::Strict::Int.default(0x0)
        attribute :vals_3, Syscase::Types::Strict::Int.default(0x0)
        attribute :vals_4, Syscase::Types::Strict::Int.default(0x0)
        attribute :vals_5, Syscase::Types::Strict::Int.default(0x0)
        attribute :vals_6, Syscase::Types::Strict::Int.default(0x0)
        attribute :vals_7, Syscase::Types::Strict::Int.default(0x0)

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
