# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Examples relation
        class Examples < ROM::Relation[:sql]
          include LB::Persistence::Relation::Joins

          schema(:examples) do
            attribute :id,     ROM::SQL::Types::Serial
            attribute :input,  ROM::SQL::Types::String
            attribute :result, ROM::SQL::Types::String
            attribute :hash,   ROM::SQL::Types::String
            attribute :path,   ROM::SQL::Types::String
            attribute :time,   ROM::SQL::Types::DateTime

            primary_key :id

            associations do
              has_many :paths
              has_many :example_counts
              has_many :addresses, through: :paths
            end
          end

          def by_id(id)
            where(id: id)
          end

          def by_hash(hash)
            where(hash: hash)
          end

          def joined
            left_join_all_qualified(addresses_joins)
              .select_append(*joined_attributes)
              .sum(:count)
          end

          def with_addresses
            joined.map_with(:examples_with_addresses)
          end

          private

          def joined_attributes
            prefixed(examples) + prefixed(paths) + prefixed(addresses)
          end

          def addresses_joins
            {
              example_counts: { examples[:id] => paths[:example] },
              paths: { examples[:id] => paths[:example] },
              addresses: { addresses[:address] => paths[:address] }
            }
          end
        end
      end
    end
  end
end
