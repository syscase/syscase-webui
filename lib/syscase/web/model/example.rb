# frozen_string_literal: true

class Syscase
  class Web
    class Model
      # Example model
      class Example < self
        attribute :input,      Syscase::Web::Types::Strict::String
        attribute :result,     Syscase::Web::Types::Strict::String
        attribute :sha256,     Syscase::Web::Types::Strict::String
        attribute :path,       Syscase::Web::Types::Strict::String
        attribute :time,       Syscase::Web::Types::Strict::Time
        attribute :secure_log, Syscase::Web::Types::Strict::String
        attribute :normal_log, Syscase::Web::Types::Strict::String
        attribute :qemu_log,   Syscase::Web::Types::Strict::String
      end
    end
  end
end
