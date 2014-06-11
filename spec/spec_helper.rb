# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'

  # factory girl shortcuts
  config.include FactoryGirl::Syntax::Methods
  # Features helpers
  config.include Capybara::ActiveAdminHelpers, type: :feature

  config.before(:suite) do
    # Ensure database is empty before running specs
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    # Switch to truncation if example uses transactions
    DatabaseCleaner.strategy = Capybara.current_driver == :rack_test ? :transaction : :truncation
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
