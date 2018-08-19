# frozen_string_literal: true

class Syscase
  class Web
    class Page
      # The coverage page
      class Coverage < self
        setting :template, 'coverage'

        register_page_as :coverage

        def examples
          Syscase::Web.db.container.relations.fetch(:examples).to_a
        end

        def name_for(example)
          [
            format('%05d', example.fetch(:id)),
            example.fetch(:result)
          ].join(':')
        end
      end
    end
  end
end
