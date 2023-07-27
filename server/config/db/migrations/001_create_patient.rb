# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:patients) do
      String :cpf, primary_key: true
      String :name
      String :email
      Date :birth_date
      String :address
      String :city
      String :state
    end
  end
end
