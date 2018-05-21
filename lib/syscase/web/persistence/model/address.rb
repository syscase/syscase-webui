# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence address model
        class Address < Syscase::Web::Model::Address
          attribute :file, Syscase::Web::Types::Strict::Int
          attribute :line, Syscase::Web::Types::Strict::Int
        end
      end
    end
  end
end
