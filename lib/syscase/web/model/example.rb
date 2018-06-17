# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Example model
      class Example < self
        attribute :input, Syscase::Web::Types::Strict::String
        attribute :hash, Syscase::Web::Types::Strict::String
        attribute :path, Syscase::Web::Types::Strict::String
        attribute :time, Syscase::Web::Types::Strict::DateTime
        attribute :count, Syscase::Web::Types::Strict::Int
      end
    end
  end
end
