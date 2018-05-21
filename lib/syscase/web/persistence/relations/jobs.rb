# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Jobs relation
        class Jobs < ROM::Relation[:sql]
          schema(:jobs) do
            attribute :id, ROM::SQL::Types::Serial
            primary_key :id

            attribute :state, Syscase::Web::Types::State
            attribute :input, ROM::SQL::Types::String
            attribute :hash, ROM::SQL::Types::String
            attribute :path, ROM::SQL::Types::String
            attribute :time, ROM::SQL::Types::DateTime
          end

          def by_id(id)
            where(id: id)
          end

          def by_hash(hash)
            where(hash: hash)
          end
        end
      end
    end
  end
end
