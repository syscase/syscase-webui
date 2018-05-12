# frozen_string_literal: true

class Syscase
  class Web
    class Page
      # The coverage page
      class Coverage < self
        setting :template, 'coverage'

        register_page_as :coverage
      end
    end
  end
end
