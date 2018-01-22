ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'ffaker'
require 'date'
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/app/helpers/'
  add_filter 'app/models/user'
end

Dir[Rails.root.join('app/decorators/api/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers
  config.include ApiFunctions
  config.include Functions

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
