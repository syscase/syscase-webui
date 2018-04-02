# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 14
      class Example14 < self
        # rubocop:disable Metrics/MethodLength
        def describe
          [
            [
              optee_disable_shm_cache,
              0,
              0,
              0,
              0,
              0,
              0,
              client0
            ]
          ]
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
