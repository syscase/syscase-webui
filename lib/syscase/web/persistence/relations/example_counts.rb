# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Example counts relation
        class ExampleCounts < ROM::Relation[:sql]
          include LB::Persistence::Relation::Joins

          schema(:example_counts) do
            attribute :id,      ROM::SQL::Types::Serial
            attribute :example, ROM::SQL::Types::ForeignKey(:examples)
            attribute :count,   ROM::SQL::Types::Int

            primary_key :id

            associations do
              belongs_to :examples
            end
          end

          def by_id(id)
            where(id: id)
          end

          def by_example(example)
            where(example: example)
          end

          def sum(example)
            by_example(example).sum(:count)
          end
        end
      end
    end
  end
end
