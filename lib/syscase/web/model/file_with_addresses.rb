# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # File model with nested addresses
      class FileWithAddresses < File
        attribute :lines, Syscase::Web::Types::Strict::Array
          .of(Syscase::Web::Model::LineWithAddresses)
      end
    end
  end
end
