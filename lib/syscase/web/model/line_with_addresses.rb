# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Line model with nested addresses
      class LineWithAddresses < Line
        attribute :addresses, Syscase::Web::Types::Strict::Array
          .of(Syscase::Web::Model::Address)
      end
    end
  end
end
