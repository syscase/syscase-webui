# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Example count model
      class ExampleCount < self
        attribute :example, Syscase::Web::Types::Strict::Int
        attribute :count,   Syscase::Web::Types::Strict::Int
      end
    end
  end
end
