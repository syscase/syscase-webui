# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Functions relation
        class Functions < ROM::Relation[:sql]
          include LB::Persistence::Relation::Joins

          schema(:functions) do
            attribute :id, ROM::SQL::Types::Serial
            primary_key :id

            attribute :name, ROM::SQL::Types::String
            attribute :signature, ROM::SQL::Types::String
            attribute :file, ROM::SQL::Types::ForeignKey(:files)

            associations do
              belongs_to :files
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
            joined.map_with(:functions_with_addresses)
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
              lines: { functions[:id] => lines[:function] },
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
