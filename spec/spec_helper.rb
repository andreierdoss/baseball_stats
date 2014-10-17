$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'baseball_stats'

require 'factory_girl'
require 'mongoid'
require 'database_cleaner'

require_relative '../spec/factories'

ENV['MONGOID_ENV'] = 'test'
Mongoid.load!("mongoid.yml")

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:mongoid].clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
