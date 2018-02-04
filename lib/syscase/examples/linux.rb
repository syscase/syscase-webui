# frozen_string_literal: true

class Syscase
  class Examples
    # Linux
    class Linux < self
      def describe
        describe_of(Syscase::Example::Linux, 7)
      end
    end
  end
end
