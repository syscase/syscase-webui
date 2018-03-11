# frozen_string_literal: true

class Syscase
  class Example
    class OPTEE
      # OPTEE Example 5
      class Example5 < self
        def describe
          [[get_property, 1, 1, prop_name, l, buf, l, buf]]
        end
      end
    end
  end
end
