# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # File model
      class File < self
        attribute :name, Syscase::Web::Types::Strict::String
      end
    end
  end
end
