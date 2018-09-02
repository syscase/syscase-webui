# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Path model
      class Path < self
        attribute :index,     Syscase::Web::Types::Strict::Int
        attribute :address,   Syscase::Web::Types::Coercible::Int
        attribute :start,     Syscase::Web::Types::Coercible::Int
        attribute :end,       Syscase::Web::Types::Coercible::Int
        attribute :level,     Syscase::Web::Types::Strict::Int
        attribute :is_secure, Syscase::Web::Types::Strict::Bool

        def secure?
          is_secure
        end
      end
    end
  end
end
