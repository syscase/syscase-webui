# frozen_string_literal: true

class Syscase
  class Example
    class Linux
      # Linux Example 5
      class Example5 < self
        def describe
          [[writev, 1, iov, 2]]
        end
      end
    end
  end
end
