# frozen_string_literal: true

class Syscase
  class Model
    # OPTEE model
    class OPTEE
      # SMC model
      class SMC
        # Msg model
        class Msg < Syscase::Model
          # Param model
          class Param < Syscase::Model
            constructor_type :schema
            attribute :attr, Syscase::Types::Strict::Int.default(0x0)
            attribute :tmem_buf_ptr, Syscase::Types::Coercible::Int.default(0x0)
            attribute :tmem_size, Syscase::Types::Strict::Int.default(0x0)
            attribute :tmem_shm_ref, Syscase::Types::Strict::Int.default(0x0)
            attribute :rmem_offs, Syscase::Types::Strict::Int.default(0x0)
            attribute :rmem_size, Syscase::Types::Strict::Int.default(0x0)
            attribute :rmem_shm_ref, Syscase::Types::Strict::Int.default(0x0)
            attribute :a, Syscase::Types::Strict::Int.default(0x0)
            attribute :b, Syscase::Types::Strict::Int.default(0x0)
            attribute :c, Syscase::Types::Strict::Int.default(0x0)
          end

          constructor_type :schema

          attribute :cmd, Syscase::Types::Strict::Int
          attribute :func, Syscase::Types::Strict::Int.default(0x0)
          attribute :session, Syscase::Types::Strict::Int.default(0x0)
          attribute :cancel_id, Syscase::Types::Strict::Int.default(0x0)
          attribute :pad, Syscase::Types::Strict::Int.default(0x0)
          attribute :ret, Syscase::Types::Strict::Int.default(0x0)
          attribute :ret_origin, Syscase::Types::Strict::Int.default(0x0)
          attribute :num_params, Syscase::Types::Strict::Int.default(0x0)
          attribute :params, Syscase::Types::Strict::Array.of(Param)

          def pack(buffer)
            to_h.each_value do |value|
              if value.is_a?(Array)
                value.each { |param| pack_param(buffer, param) }
              else
                buffer.pack('L>', value)
              end
            end
          end

          def pack_param(buffer, param)
            param.each_value do |value|
              buffer.pack('Q>', value)
            end
          end
        end
      end
    end
  end
end
