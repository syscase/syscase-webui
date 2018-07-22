# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Path model with nested addresses
      class PathWithAddresses < Path
        attribute :addresses, Syscase::Web::Types::Strict::Array
          .of(Syscase::Web::Model::Address)
      end
    end
  end
end
