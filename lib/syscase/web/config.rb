# frozen_string_literal: true

class Syscase
  class Web
    # Syscase::Web Configuration
    class Config < LB::Project::Config
      attribute :database_uri, Types::Strict::String
      attribute :session_secret, Types::Strict::String
      attribute :session_key, Types::Strict::String
      attribute :session_domain, Types::Strict::String
    end
  end
end
