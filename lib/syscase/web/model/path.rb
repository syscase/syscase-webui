# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Path model
      class Path < self
        attribute :index,   Syscase::Web::Types::Strict::Int
        attribute :address, Syscase::Web::Types::Coercible::Int
      end
    end
  end
end
