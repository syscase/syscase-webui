# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Mappers
        # File with nested addresses mapper
        class FileWithAddresses < ROM::Transformer
          relation :files
          register_as :file_with_addresses

          group_prefix(
            :addresses,
            %i[address_file address_line address_address address_code],
            'address_',
            Syscase::Web::Persistence::Model::Address
          )

          group_prefix(
            :lines,
            %i[line_file line_function line_line line_code addresses],
            'line_',
            Syscase::Web::Persistence::Model::LineWithAddresses
          )

          model Syscase::Web::Persistence::Model::FileWithAddresses
        end
      end
    end
  end
end
