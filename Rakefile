# frozen_string_literal: true
# encoding: utf-8

require 'devtools'

Devtools.init_rake_tasks

require 'rom/sql/rake_task'

namespace :db do
  task :setup do
    require 'syscase'
    ROM::SQL::RakeSupport.env = Syscase::Web.db.container
  end
end
