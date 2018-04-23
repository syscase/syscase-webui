# frozen_string_literal: true

class Syscase
  class Model
    # OPTEE model
    class OPTEE
      # UTEEAttribute model
      class UTEEAttribute < Syscase::Model
        constructor_type :schema

        attribute :a, Syscase::Types::Strict::Int.default(0x0)
        attribute :b, Syscase::Types::Strict::Int.default(0x0)
        attribute :id, Syscase::Types::Strict::Int.default(0x0)

        def pack(buffer)
          buffer.pack('Q>', a)
          buffer.pack('Q>', b)
          buffer.pack('L>', id)
        end
      end
    end
  end
end
