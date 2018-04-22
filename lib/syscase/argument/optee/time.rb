# frozen_string_literal: true

class Syscase
  class Argument
    # OPTEE argument
    class OPTEE
      # Time argument
      class Time < Syscase::Argument
        def initialize(time)
          @time = time
        end

        def call(buffer, _extra)
          pack_with(buffer, '!C', 64)
          @time.pack(buffer)
        end
      end
    end
  end
end
