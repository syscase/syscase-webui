# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Relations
        # Lines relation
        class Lines < ROM::Relation[:sql]
          schema(:lines) do
            attribute :file, ROM::SQL::Types::ForeignKey(:files)
            attribute :line, ROM::SQL::Types::Int
            primary_key :file, :line

            attribute :code, ROM::SQL::Types::String

            associations do
              has_many :addresses
              belongs_to :files
            end
          end

          def by_id(file, line)
            where(file: file, line: line)
          end

          def by_file(file)
            where(file: file)
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
