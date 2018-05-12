# frozen_string_literal: true

class Syscase
  class Web
    # Syscase::Web base route
    class Route < LB::Project::App
      LB::Project::Route.setup(self)

      use Rack::Session::Cookie, Syscase::Web.session_settings
      use Rack::Csrf, raise: true
    end
  end
end
