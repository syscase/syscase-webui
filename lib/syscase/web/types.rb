# frozen_string_literal: true

class Syscase
  class Web
    # Syscase::Web types
    module Types
      include Dry::Types.module

      State = Types::Strict::String.enum('scheduled', 'running', 'successful',
                                         'failed')
    end
  end
end
