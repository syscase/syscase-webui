# frozen_string_literal: true

class Syscase
  class Argument
    class String
      # String with zero byte
      class Z < self
        def initialize(value)
          super(value + %(\0))
        end
      end
    end
  end
end
