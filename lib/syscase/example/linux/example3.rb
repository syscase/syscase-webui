# frozen_string_literal: true

class Syscase
  class Example
    class Linux
      # Linux Example 3
      class Example3 < self
        def describe
          describe_of(Example1, Example2)
        end
      end
    end
  end
end
