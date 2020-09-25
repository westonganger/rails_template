# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

ENV['COVERAGE'] = 'PartialSummary'
#ENV['COVERAGE'] = 'BriefSummary'
#ENV['COVERAGE'] = 'Summary'

RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-performance'
end
