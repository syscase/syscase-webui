# frozen_string_literal: true

# LB
require 'lb-project'

# Rendering
require 'slim'

# Syscase::Web
require 'syscase/web/types'
require 'syscase/web/config'
require 'syscase/web/site'

class Syscase
  # Web interface
  class Web
    extend LB::Project::API

    CONFIG_FILE = "#{ENV['HOME']}/.syscase/config.yml"

    def self.setup
      settings = LB::Project::Settings.new(
        root: LB::Project.root_for(__FILE__, 3),
        config: Syscase::Web::Config.load(CONFIG_FILE, Syscase::Web::Config),
        site: Syscase::Web::Site
      )
      LB::Project.setup(settings)
    end

    setup

    def self.session_settings
      {
        secret: config.session_secret,
        key: config.session_key,
        domain: config.session_domain,
        expire_after: 60 * 60 * 24 * 30
      }
    end

    def self.db
      @db ||= LB::Persistence.new(
        LB::Persistence::Settings.new(
          source_dir: File.join(root, 'lib/syscase/web/persistence'),
          namespace: 'Syscase::Web::Persistence',
          database_uri: config.database_uri
        )
      )
    end
  end
end

# Pages
require 'syscase/web/page'
require 'syscase/web/page/coverage'

# Routes
require 'syscase/web/route'
require 'syscase/web/route/coverage'
require 'syscase/web/app'
