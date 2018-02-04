# frozen_string_literal: true

class Syscase
  class Example
    class Linux
      # Linux Example 1
      class Example1 < self
        def describe
          [[write, 1, %(hello World!\n), l]]
        end
      end
    end
  end
end
