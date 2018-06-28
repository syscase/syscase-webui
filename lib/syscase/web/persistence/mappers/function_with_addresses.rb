# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Mappers
        # Function with nested addresses mapper
        class FunctionWithAddresses < ROM::Transformer
          relation :functions
          register_as :function_with_addresses

          wrap_prefix(
            :file,
            %i[file_id file_name],
            'file_',
            Syscase::Web::Persistence::Model::File
          )

          group_prefix(
            :addresses,
            %i[address_id address_line address_address address_code],
            'address_',
            Syscase::Web::Persistence::Model::Address
          )

          wrap_prefix(
            :line_file,
            %i[line_file_id line_file_name],
            'line_file_',
            Syscase::Web::Persistence::Model::File
          )

          group_prefix(
            :lines,
            %i[line_id line_file line_function line_line line_code addresses],
            'line_',
            Syscase::Web::Persistence::Model::LineWithAddresses
          )

          model Syscase::Web::Persistence::Model::FunctionWithAddresses
        end
      end
    end
  end
end
