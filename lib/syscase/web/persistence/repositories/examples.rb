# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Repositories
        # Examples repository
        class Examples < ROM::Repository[:examples]
          # Disable auto_struct feature to enable custom mappers
          auto_struct false

          commands :create, update: :by_pk, delete: :by_pk

          def by_hash(sha256)
            examples.by_hash(sha256)
          end
        end
      end
    end
  end
end
