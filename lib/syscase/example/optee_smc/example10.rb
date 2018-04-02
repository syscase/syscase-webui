# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 10
      class Example10 < self
        def describe
          [[optee_shm_l2cc_mutex, mutex_enable, 0, 0, 0, 0, 0, client0]]
        end
      end
    end
  end
end
