# frozen_string_literal: true

class Syscase
  class Example
    class OPTEE
      # OPTEE Example 3
      class Example3 < self
        def describe
          describe_of(Example2, Example1)
        end
      end
    end
  end
end
