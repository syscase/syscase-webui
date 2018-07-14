# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence path model
        class Path < Syscase::Web::Model::Path
          attribute :example, Syscase::Web::Types::Strict::Int
        end
      end
    end
  end
end
