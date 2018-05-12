# frozen_string_literal: true

class Syscase
  class Web
    class Route
      # Coverage route
      class Coverage < self
        route do |r|
          r.is do
            r.get do
              page :coverage
            end
          end
        end
      end
    end
  end
end
