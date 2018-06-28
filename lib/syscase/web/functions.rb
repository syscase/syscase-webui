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
        def wrap_prefix(array, key, keys, prefix, model = nil)
          compose do |ops|
            ops << t(:wrap, key, keys)
            ops << t(:map_array,
                     t(:remove_key_prefix_inject_hash_for, key, prefix, model))
          end.call(array)
        end

        def remove_key_prefix_inject_hash_for(hash, key, prefix, model = nil)
          t(:map_value, key,
            t(:remove_key_prefix_inject, prefix, model)).call(hash)
        end
      end
    end
  end
end
