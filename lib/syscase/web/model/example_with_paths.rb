# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Example model with nested paths
      class ExampleWithPaths < Example
        attribute :paths, Syscase::Web::Types::Strict::Array
          .member(Syscase::Web::Model::Path)
      end
    end
  end
end
