# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 13
      class Example13 < self
        def describe
          [[optee_capabilities, nsec_cap_uniprocessor, 0, 0, 0, 0, 0, client0]]
        end
      end
    end
  end
end
