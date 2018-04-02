# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 19
      class Example19 < self
        def describe
          [[optee_return_rpc, addr32_high, addr32_low, 0, 0, 0, 0, client0]]
        end
      end
    end
  end
end
