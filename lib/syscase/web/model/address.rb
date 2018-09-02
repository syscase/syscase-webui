# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Address model
      class Address < self
        attribute :address, Syscase::Web::Types::Coercible::Int
        attribute :code, Syscase::Web::Types::Strict::String
      end
    end
  end
end
