# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence example model
        class Example < Syscase::Web::Model::Example
          attribute :id, Syscase::Web::Types::Strict::Int
        end
      end
    end
  end
end
