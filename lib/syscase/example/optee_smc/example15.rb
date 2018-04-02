# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 15
      class Example15 < self
        def describe
          [[optee_enable_shm_cache, 0, 0, 0, 0, 0, 0, client0]]
        end
      end
    end
  end
end
