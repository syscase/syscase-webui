# frozen_string_literal: true

class Syscase
  class Model
    # OPTEE model
    class OPTEE
      # SMC model
      class SMC
        # Msg model
        class Msg < Syscase::Model::WithDefaults
          # Param model
          class Param < Syscase::Model::WithDefaults
            attribute :attr, INTEGER.default(0x0)
            attribute :tmem_buf_ptr, INTEGER.default(0x0)
            attribute :tmem_size, INTEGER.default(0x0)
            attribute :tmem_shm_ref, INTEGER.default(0x0)
            attribute :rmem_offs, INTEGER.default(0x0)
            attribute :rmem_size, INTEGER.default(0x0)
            attribute :rmem_shm_ref, INTEGER.default(0x0)
            attribute :a, INTEGER.default(0x0)
            attribute :b, INTEGER.default(0x0)
            attribute :c, INTEGER.default(0x0)
          end
          attribute :cmd, INTEGER
          attribute :func, INTEGER.default(0x0)
          attribute :session, INTEGER.default(0x0)
          attribute :cancel_id, INTEGER.default(0x0)
          attribute :pad, INTEGER.default(0x0)
          attribute :ret, INTEGER.default(0x0)
          attribute :ret_origin, INTEGER.default(0x0)
          attribute :num_params, INTEGER.default(0x0)
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
