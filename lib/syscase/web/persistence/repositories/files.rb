# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Repositories
        # Files repository
        class Files < ROM::Repository[:files]
          # Disable auto_struct feature to enable custom mappers
          auto_struct false

          commands :create, update: :by_pk, delete: :by_pk

          def as(relation)
            relation.joined.map_with(repository_mapper)
          end

          def prepared_aggregation
            aggregate(:addresses)
          end

          def base_relation
            files
          end

          def repository_mapper
            :file_with_addresses
          end

          # TODO: Extract basic methods:

          def by_id(id)
            as_one(prepared_aggregation.by_id(id))
          end

          def all
            as_many(prepared_aggregation)
          end

          def changeset(id, command, entity)
            base_relation.by_pk(id).changeset(command, entity)
          end

          def as_one(relation)
            as(relation).one!
          end

          def as_many(relation)
            as(relation).to_a
          end
        end
      end
    end
  end
end
