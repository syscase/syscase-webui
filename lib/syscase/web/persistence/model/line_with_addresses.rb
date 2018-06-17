# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence line model with nested addresses
        class LineWithAddresses < Syscase::Web::Model::LineWithAddresses
          extend LB::Persistence::Model::Attributes

          attribute :file, Syscase::Web::Types::Strict::Int
          attribute :function, Syscase::Web::Types::Strict::Int

          redefine_attribute :addresses, Syscase::Web::Types::Strict::Array
            .member(Syscase::Web::Persistence::Model::Address)
        end
      end
    end
  end
end
