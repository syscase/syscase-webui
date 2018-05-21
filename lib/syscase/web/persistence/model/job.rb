# frozen_string_literal: true

class Syscase
  class Web
    module Persistence
      module Model
        # Persistence job model
        class Job < Syscase::Web::Model::Job
          attribute :id, Syscase::Web::Types::Strict::Int
        end
      end
    end
  end
end
