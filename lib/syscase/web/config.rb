# frozen_string_literal: true

class Syscase
  class Web
    # Syscase::Web Configuration
    class Config < LB::Project::Config
      attribute :database_name, Types::Strict::String
      attribute :database_user, Types::Strict::String
      attribute :database_password, Types::Strict::String
      attribute :database_host, Types::Strict::String
      attribute :session_secret, Types::Strict::String
      attribute :session_key, Types::Strict::String
      attribute :session_domain, Types::Strict::String
    end
  end
end
