# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Job model
      class Job < self
        attribute :state, Syscase::Web::Types::State
        attribute :input, Syscase::Web::Types::Strict::String
        attribute :hash, Syscase::Web::Types::Strict::String
        attribute :path, Syscase::Web::Types::Strict::String
        attribute :time, Syscase::Web::Types::Strict::DateTime
      end
    end
  end
end
