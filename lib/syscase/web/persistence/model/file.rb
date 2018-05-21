# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence file model
        class File < Syscase::Web::Model::File
          attribute :id, Syscase::Web::Types::Strict::Int
        end
      end
    end
  end
end
