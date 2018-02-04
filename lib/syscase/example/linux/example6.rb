# frozen_string_literal: true

class Syscase
  class Example
    class Linux
      # Linux Example 6
      class Example6 < self
        def describe
          [[open, filename, 0], [read, 3, buf, l]]
        end
      end
    end
  end
end
