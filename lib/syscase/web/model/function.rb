# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Function model
      class Function < self
        attribute :name, Syscase::Web::Types::Strict::String
        attribute :signature, Syscase::Web::Types::Strict::String
        attribute :file, Syscase::Web::Model::File
      end
    end
  end
end
