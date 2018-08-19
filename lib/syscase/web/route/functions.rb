# frozen_string_literal: true

class Syscase
  class Web
    class Route
      # Functions route
      class Functions < self
        route do |r|
          r.get do
            page :functions
          end
        end
      end
    end
  end
end
