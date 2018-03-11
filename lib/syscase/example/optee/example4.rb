# frozen_string_literal: true

class Syscase
  class Example
    class OPTEE
      # OPTEE Example 4
      class Example4 < self
        def describe
          [[close_session, 0x67bb0]]
        end
      end
    end
  end
end
