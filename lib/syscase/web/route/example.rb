# frozen_string_literal: true

class Syscase
  class Web
    class Route
      # Example route
      class Example < self
        route do |r|
          r.get Integer do |id|
            page :example, id: id
          end
        end
      end
    end
  end
end
