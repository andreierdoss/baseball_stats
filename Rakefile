require 'baseball_stats'
require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

ENV['MONGOID_ENV'] = 'development'
Mongoid.load!("mongoid.yml")

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color', '--format', 'nested']
end

task default: :spec

Dir.glob('lib/tasks/*.rake').each { |r| import r }
