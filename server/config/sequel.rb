# frozen_string_literal: true

require 'sequel'

module Config
  class Database
    def self.instance
      @instance ||= Sequel.connect(ENV['DB_URI'], max_connection: 10)
    end
  end
end
