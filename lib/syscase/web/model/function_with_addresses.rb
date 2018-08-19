# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Function model with nested addresses
      class FunctionWithAddresses < Function
        attribute :lines, Syscase::Web::Types::Strict::Array
          .of(Syscase::Web::Model::LineWithAddresses)
      end
    end
  end
end
