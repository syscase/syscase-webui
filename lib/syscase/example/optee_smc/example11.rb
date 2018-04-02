# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 11
      class Example11 < self
        def describe
          [[optee_shm_l2cc_mutex, mutex_disable, 0, 0, 0, 0, 0, client0]]
        end
      end
    end
  end
end
