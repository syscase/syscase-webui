# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Line model
      class Line < self
        attribute :file, Syscase::Web::Model::File
        attribute :line, Syscase::Web::Types::Strict::Int
        attribute :code, Syscase::Web::Types::Strict::String
      end
    end
  end
end
