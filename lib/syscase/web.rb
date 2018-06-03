# frozen_string_literal: true

require 'bundler/setup'

# LB
require 'lb-persistence'
require 'lb-project'

# ROM
require 'rom/transformer'

# Rendering
require 'slim'

# Syscase::Web
require 'syscase/web/types'
require 'syscase/web/functions'
require 'syscase/web/config'
require 'syscase/web/site'

# Import transproc functions
ROM::Processor::Transproc::Functions.tap do |registry|
  registry.import LB::Persistence::Functions
  registry.import Syscase::Web::Functions
end

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

# Models
require 'syscase/web/model'
require 'syscase/web/model/file'
require 'syscase/web/model/function'
require 'syscase/web/model/line'
require 'syscase/web/model/address'
require 'syscase/web/model/example'
require 'syscase/web/model/path'
require 'syscase/web/model/job'
require 'syscase/web/model/line_with_addresses'
require 'syscase/web/model/function_with_addresses'
require 'syscase/web/model/file_with_addresses'
require 'syscase/web/model/path_with_addresses'
require 'syscase/web/model/example_with_addresses'

# Persistence models
require 'syscase/web/persistence/model/file'
require 'syscase/web/persistence/model/function'
require 'syscase/web/persistence/model/line'
require 'syscase/web/persistence/model/address'
require 'syscase/web/persistence/model/example'
require 'syscase/web/persistence/model/path'
require 'syscase/web/persistence/model/job'
require 'syscase/web/persistence/model/line_with_addresses'
require 'syscase/web/persistence/model/function_with_addresses'
require 'syscase/web/persistence/model/file_with_addresses'
require 'syscase/web/persistence/model/path_with_addresses'
require 'syscase/web/persistence/model/example_with_addresses'

# Repositories
require 'syscase/web/persistence/repositories/files'
require 'syscase/web/persistence/repositories/functions'
require 'syscase/web/persistence/repositories/lines'
require 'syscase/web/persistence/repositories/addresses'
require 'syscase/web/persistence/repositories/examples'
require 'syscase/web/persistence/repositories/paths'
require 'syscase/web/persistence/repositories/jobs'

# Pages
require 'syscase/web/page'
require 'syscase/web/page/coverage'

# Routes
require 'syscase/web/route'
require 'syscase/web/route/coverage'
require 'syscase/web/app'

# Import
require 'syscase/web/gdb'
