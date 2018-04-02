# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 24
      class Example24 < self
        # rubocop:disable Metrics/MethodLength
        def describe
          [
            [
              optee_with_arg,
              addr32_optee_msg_arg_high,
              addr32_optee_msg_arg_low,
              smc_shm_cached,
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
