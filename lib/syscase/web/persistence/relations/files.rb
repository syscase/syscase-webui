# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Files relation
        class Files < ROM::Relation[:sql]
          include LB::Persistence::Relation::Joins

          schema(:files) do
            attribute :id, ROM::SQL::Types::Serial
            primary_key :id

            attribute :name, ROM::SQL::Types::String

            associations do
              has_many :lines
              has_many :addresses, through: :lines
            end
          end

          def by_id(id)
            where(id: id)
          end

          def by_name(name)
            where(name: name)
          end

          def joined
            left_join_all_qualified(addresses_joins)
              .select_append(*lines_attributes)
              .select_append(*addresses_attributes)
          end

          def with_addresses
            joined.map_with(:files_with_addresses)
          end

          private

          def lines_attributes
            prefixed(lines)
          end

          def addresses_attributes
            prefixed(addresses)
          end

          def addresses_joins
            {
              lines: { files[:id] => lines[:file] },
              addresses: {
                addresses[:file] => lines[:file],
                addresses[:line] => lines[:line]
              }
            }
          end
        end
      end
    end
  end
end
