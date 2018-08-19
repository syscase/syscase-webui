# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Repositories
        # Functions repository
        class Functions < ROM::Repository[:functions]
          # Disable auto_struct feature to enable custom mappers
          auto_struct false

          def by_id(id)
            map(function.joined.by_id(id))
          end

          def all
            map(functions.joined)
          end

          def map(relation)
            relation.map_with(repository_mapper)
          end

          private

          def repository_mapper
            :function_with_addresses
          end
        end
      end
    end
  end
end
