# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence function model
        class Function < Syscase::Web::Model::Function
          attribute :id, Syscase::Web::Types::Strict::Int
        end
      end
    end
  end
end
