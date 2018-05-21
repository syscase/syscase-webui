# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence file model with nested addresses
        class FileWithAddresses < Syscase::Web::Model::FileWithAddresses
          extend LB::Persistence::Model::Attributes

          attribute :id, Syscase::Web::Types::Strict::Int

          redefine_attribute :lines, Syscase::Web::Types::Strict::Array
            .member(Syscase::Web::Persistence::Model::LineWithAddresses)
        end
      end
    end
  end
end
