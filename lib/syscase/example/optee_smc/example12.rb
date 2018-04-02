# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 12
      class Example12 < self
        # rubocop:disable Metrics/MethodLength
        def describe
          [
            [optee_shm_l2cc_mutex, mutex_enable, 0, 0, 0, 0, 0, client0],
            [
              optee_shm_l2cc_mutex,
              mutex_set_addr,
              addr32_high,
              addr32_low,
              0,
              0,
              0,
              client0
            ],
            [optee_shm_l2cc_mutex, mutex_get_addr, 0, 0, 0, 0, 0, client0]
          ]
        end
        # rubocop:enable Metrics/MethodLength
      end
    end
  end
end
