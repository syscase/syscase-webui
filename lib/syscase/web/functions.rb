# frozen_string_literal: true

class Syscase
  class Web
    # Custom transproc functions
    module Functions
      extend Transproc::Registry
      extend Transproc::Composer

      import Transproc::Coercions
      import Transproc::Conditional
      import Transproc::ArrayTransformations
      import Transproc::HashTransformations
      import Transproc::ClassTransformations
      import Transproc::ProcTransformations
      import LB::Persistence::Functions

      class << self
      end
    end
  end
end
