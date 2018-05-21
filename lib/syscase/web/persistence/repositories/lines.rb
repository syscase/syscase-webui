# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Repositories
        # Lines repository
        class Lines < ROM::Repository[:lines]
          # Disable auto_struct feature to enable custom mappers
          auto_struct false

          commands :create, update: :by_pk, delete: :by_pk
        end
      end
    end
  end
end
