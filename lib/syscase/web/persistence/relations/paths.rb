# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Paths relation
        class Paths < ROM::Relation[:sql]
          schema(:paths) do
            attribute :example, ROM::SQL::Types::ForeignKey(:examples)
            attribute :index, ROM::SQL::Types::Int
            primary_key :example, :index

            attribute :address, ROM::SQL::Types::ForeignKey(:addresses)

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
