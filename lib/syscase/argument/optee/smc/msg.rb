# frozen_string_literal: true

class Syscase
  class Argument
    # OPTEE argument
    class OPTEE
      # SMC argument
      class SMC
        # Msg argument
        class Msg < Syscase::Argument
          def initialize(msg)
            @msg = msg
          end

          def call(buffer, _extra)
            pack_with(buffer, '!C', 32)
            @msg.pack(buffer)
          end
        end
      end
    end
  end
end
