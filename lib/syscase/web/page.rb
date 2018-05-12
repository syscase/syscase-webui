# frozen_string_literal: true

class Syscase
  class Web
    # Base page
    class Page < LB::Project::Page
      LB::Project::View.setup(self)
    end
  end
end
