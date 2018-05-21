# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence line model
        class Line < Syscase::Web::Model::Line
          attribute :file, Syscase::Web::Types::Strict::Int
        end
      end
    end
  end
end
