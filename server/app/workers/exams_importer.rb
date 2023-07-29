# frozen_string_literal: true

require 'sidekiq'
require 'sequel'
require './domain/service/save_all_in_database'

DB = Sequel.connect(ENV['DB_URI'])

module Worker
  class ExamsImporter
    include Sidekiq::Worker
    include Service

    def perform(data)
      SaveAllInDatabase.new(data).call
    end
  end
end
