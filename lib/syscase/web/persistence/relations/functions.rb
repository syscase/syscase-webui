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
            left_join_all_qualified(base_joins)
              .left_join(:files, line_files_on, table_alias: :line_files)
              .left_join_all_qualified(addresses_joins)
              .select_append(*files_attributes)
              .select_append(*lines_attributes)
              .select_append(*line_files_attributes)
              .select_append(*addresses_attributes)
          end

          def with_addresses
            joined.map_with(:functions_with_addresses)
          end

          private

          def files_attributes
            prefixed(files)
          end

          def lines_attributes
            prefixed(lines)
          end

          def line_files_attributes
            # Use qualified to set table alias, `prefixed` does not support
            # setting table alias
            # TODO: Add support for setting table alias in upstream
            # implementation
            prefixed(files.qualified(:line_files), :line_file)
          end

          def addresses_attributes
            prefixed(addresses)
          end

          def base_joins
            {
              files: { functions[:file] => files[:id]       },
              lines: { functions[:id]   => lines[:function] }
            }
          end

          def line_files_on
            { lines[:file].qualified => files[:id].qualified(:line_files) }
          end

          def addresses_joins
            {
              addresses: { addresses[:line] => lines[:line] }
            }
          end
        end
      end
    end
  end
end
