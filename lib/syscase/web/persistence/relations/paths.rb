# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Paths relation
        class Paths < ROM::Relation[:sql]
          schema(:paths) do
            attribute :id, ROM::SQL::Types::Serial
            primary_key :id

            attribute :example,   ROM::SQL::Types::ForeignKey(:examples)
            attribute :index,     ROM::SQL::Types::Int

            attribute :address,   ROM::SQL::Types::ForeignKey(:addresses)
            attribute :start,     ROM::SQL::Types::Int
            attribute :end,       ROM::SQL::Types::Int
            attribute :level,     ROM::SQL::Types::Int
            attribute :is_secure, ROM::SQL::Types::Bool

            associations do
              belongs_to :addresses
            end
          end

          def by_id(example, index)
            where(example: example, index: index)
          end

          def by_address(address)
            where(address: address)
          end

          def code_by_example(example)
            join_addresses_for_example(
              select(paths[:index], addresses[:code]),
              example
            ).distinct.order(paths[:index])
          end

          def coverage_count
            join_addresses.select(paths[:address])
                          .order(paths[:address])
                          .distinct.count
          end

          def join_addresses
            join(:addresses,
                 paths[:address].qualified => addresses[:address].qualified)
          end

          def join_addresses_for_example(base, example)
            base
              .join(:addresses,
                    paths[:address].qualified => addresses[:address].qualified,
                    paths[:example] => example)
          end

          def joined
            left_join(:addresses,
                      paths[:address] => addresses[:address])
          end

          def with_addresses
            joined.map_with(:path_with_addresses)
          end
        end
      end
    end
  end
end
