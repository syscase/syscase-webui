# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence example model with nested paths
        class ExampleWithPaths < Syscase::Web::Model::ExampleWithPaths
          extend LB::Persistence::Model::Attributes

          attribute :id, Syscase::Web::Types::Strict::Int

          redefine_attribute :paths, Syscase::Web::Types::Strict::Array
            .of(Syscase::Web::Persistence::Model::Path)
        end
      end
    end
  end
end
