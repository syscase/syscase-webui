# frozen_string_literal: true

class Syscase
  class Web
    class Page
      # The functions page
      class Functions < self
        setting :template, 'functions'

        register_page_as :functions

        attr_reader :id

        def functions
          Syscase::Web.functions
        end

        def class_for_address(address)
          found = Syscase::Web.db.repository(
            Syscase::Web::Persistence::Repositories::Paths
          ).by_address(address.address).to_a
          return 'address-uncovered' if found.empty?
          'address-covered'
        end
      end
    end
  end
end
