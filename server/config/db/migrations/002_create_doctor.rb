# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:doctors) do
      String :crm, primary_key: true
      String :name
      String :crm_state
      String :email
    end
  end
end
