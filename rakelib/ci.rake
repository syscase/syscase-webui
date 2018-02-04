# frozen_string_literal: true

# Remove existing same-named tasks
%w[ci ci:metrics].each do |task|
  klass = Rake::Task
  klass[task].clear if klass.task_defined?(task)
end

desc 'Run all specs, metrics'
# Do not use metrics:mutant because of incompatible UTF-8
task ci: %w[ci:metrics]

namespace :ci do
  tasks = %w[
    metrics:coverage
    metrics:yardstick:verify
    metrics:rubocop
    metrics:flog
    metrics:flay
    spec:integration
  ]

  desc 'Run metrics'
  task metrics: tasks
end
