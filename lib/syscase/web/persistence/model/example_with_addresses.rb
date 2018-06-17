# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence example model with nested addresses
        class ExampleWithAddresses < Syscase::Web::Model::ExampleWithAddresses
          extend LB::Persistence::Model::Attributes

          attribute :id, Syscase::Web::Types::Strict::Int

          redefine_attribute :paths, Syscase::Web::Types::Strict::Array
            .member(Syscase::Web::Persistence::Model::PathWithAddresses)
        end
      end
    end
  end
end
