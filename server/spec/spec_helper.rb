# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_group 'Models', 'domain/model'
  add_group 'Controllers', 'app/controllers'
  add_group 'Workers', 'app/workers'
  add_group 'Services', 'domain/service'
  add_group 'Repositories', 'domain/repository'
end

require './config/sequel'
DB = Config::Database.instance

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
