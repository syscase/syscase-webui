# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Addresses relation
        class Addresses < ROM::Relation[:sql]
          schema(:addresses) do
            attribute :id, ROM::SQL::Types::Serial
            primary_key :id

            attribute :line, ROM::SQL::Types::ForeignKey(:lines)

            attribute :address, ROM::SQL::Types::Int
            attribute :code, ROM::SQL::Types::String

            associations do
              belongs_to :lines
            end
          end

          def distinct_count
            select(:address).order(:address).distinct.count
          end
        end
      end
    end
  end
end
