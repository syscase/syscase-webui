# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 23
      class Example23 < self
        def describe
          [[optee_return_rpc_cmd, addr32_shm_cookie_high, addr32_shm_cookie_low]]
        end
      end
    end
  end
end
