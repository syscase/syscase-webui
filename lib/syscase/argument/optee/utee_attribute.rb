# frozen_string_literal: true

class Syscase
  class Argument
    # OPTEE argument
    class OPTEE
      # UTEEAttribute argument
      class UTEEAttribute < Syscase::Argument
        def initialize(attr)
          @attr = attr
        end

        def call(buffer, _extra)
          pack_with(buffer, '!C', 67)
          @attr.pack(buffer)
        end
      end
    end
  end
end
