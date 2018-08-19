# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence example count model
        class ExampleCount < Syscase::Web::Model::ExampleCount
          attribute :id, Syscase::Web::Types::Strict::Int
        end
      end
    end
  end
end
