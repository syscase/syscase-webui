# frozen_string_literal: true

class Syscase
  class Example
    class OPTEE
      # OPTEE Example 7
      class Example7 < self
        def describe
          [[get_time, 0, optee_time_arg]]
        end
      end
    end
  end
end
