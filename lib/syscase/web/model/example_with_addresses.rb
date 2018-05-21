# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Example model with nested addresses
      class ExampleWithAddresses < Example
        attribute :paths, Syscase::Web::Types::Strict::Array
          .member(Syscase::Web::Model::PathWithAddresses)
      end
    end
  end
end
