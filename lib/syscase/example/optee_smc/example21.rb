# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 21
      class Example21 < self
        def describe
          [[optee_return_rpc_free, addr32_shm_cookie_high, addr32_shm_cookie_low]]
        end
      end
    end
  end
end
