# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Lines relation
        class Lines < ROM::Relation[:sql]
          schema(:lines) do
            attribute :id, ROM::SQL::Types::Serial
            primary_key :id

            attribute :file, ROM::SQL::Types::ForeignKey(:files)
            attribute :function, ROM::SQL::Types::ForeignKey(:functions)

            attribute :line, ROM::SQL::Types::Int
            attribute :code, ROM::SQL::Types::String

            associations do
              has_many :addresses
              belongs_to :files
              belongs_to :functions
            end
          end

          def by_id(file, line)
            where(file: file, line: line)
          end

          def by_file(file)
            where(file: file)
          end

          def by_function(function)
            where(function: function)
          end

          def joined
            left_join(:addresses,
                      lines[:file] => addresses[:file],
                      lines[:line] => addresses[:line])
          end

          def with_addresses
            joined.map_with(:lines_with_addresses)
          end
        end
      end
    end
  end
end
