# frozen_string_literal: true

class Syscase
  class Example
    class OPTEE
      # OPTEE Example 10
      class Example10 < self
        def describe
          [[open_session, optee_uuid_arg, 0, utee_params_arg, buf, 0]]
        end
      end
    end
  end
end
