# frozen_string_literal: true
# encoding: utf-8

require 'devtools'

Devtools.init_rake_tasks

require 'rom/sql/rake_task'

namespace :db do
  task :setup do
    require 'syscase'
    db = Syscase::Web.db
    container = db.container_from(db.configuration_for(db.connect(db.uri)))
    ROM::SQL::RakeSupport.env = container
  end
end
