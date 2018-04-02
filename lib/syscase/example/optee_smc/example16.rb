# frozen_string_literal: true

class Syscase
  class Example
    class OPTEESMC
      # OPTEE SMC Example 16
      class Example16 < self
        def describe
          [
            [
              optee_boot_secondary,
              core_index1,
              addr32_entry_high,
              addr32_entry_low
            ]
          ]
        end
      end
    end
  end
end
