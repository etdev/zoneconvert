ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
abort("The Rails environment is running in production mode!") if Rails.env.production?

ActiveRecord::Migration.maintain_test_schema!
Monban.test_mode!
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Monban::Test::ControllerHelpers, type: :controller
  config.include Monban::Test::Helpers, type: :feature
  config.after :each do
    Monban.test_reset!
  end
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
