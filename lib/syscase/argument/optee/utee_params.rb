# frozen_string_literal: true

class Syscase
  class Argument
    # OPTEE argument
    class OPTEE
      # UTEEParams argument
      class UTEEParams < Syscase::Argument
        def initialize(params)
          @params = params
        end

        def call(buffer, _extra)
          pack_with(buffer, '!C', 65)
          @params.pack(buffer)
        end
      end
    end
  end
end
