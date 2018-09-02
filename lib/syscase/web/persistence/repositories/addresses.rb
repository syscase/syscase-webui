# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Repositories
        # Addresses repository
        class Addresses < ROM::Repository[:addresses]
          # Disable auto_struct feature to enable custom mappers
          auto_struct false

          commands :create, update: :by_pk, delete: :by_pk

          def count
            addresses.distinct_count
          end
        end
      end
    end
  end
end
