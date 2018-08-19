# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Repositories
        # Paths repository
        class Paths < ROM::Repository[:paths]
          # Disable auto_struct feature to enable custom mappers
          auto_struct false

          def by_address(address)
            all.by_address(address)
          end

          def all
            map(paths)
          end

          def map(relation)
            relation.map_to(Syscase::Web::Persistence::Model::Path)
          end

          def coverage_count
            paths.coverage_count
          end

          private

          def repository_mapper
            :paths
          end
        end
      end
    end
  end
end
