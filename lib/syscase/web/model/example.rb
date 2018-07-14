# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Example model
      class Example < self
        attribute :input, Syscase::Web::Types::Strict::String
        attribute :path, Syscase::Web::Types::Strict::String
        attribute :result, Syscase::Web::Types::Strict::String
        attribute :sha256, Syscase::Web::Types::Strict::String
        attribute :time,   Syscase::Web::Types::Strict::Time
      end
    end
  end
end
