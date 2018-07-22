# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence function model with nested addresses
        class FunctionWithAddresses < Syscase::Web::Model::FunctionWithAddresses
          extend LB::Persistence::Model::Attributes

          attribute :id, Syscase::Web::Types::Strict::Int

          redefine_attribute :lines, Syscase::Web::Types::Strict::Array
            .of(Syscase::Web::Persistence::Model::LineWithAddresses)
        end
      end
    end
  end
end
