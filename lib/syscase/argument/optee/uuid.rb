# frozen_string_literal: true

class Syscase
  class Argument
    # OPTEE argument
    class OPTEE
      # UUID argument
      class UUID < Syscase::Argument
        def initialize(uuid)
          @uuid = uuid
        end

        def call(buffer, _extra)
          pack_with(buffer, '!C', 66)
          @uuid.pack(buffer)
        end
      end
    end
  end
end
