# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:exams) do
      String :token, primary_key: true
      Date :date
      foreign_key :patient_cpf, :patients, type: String
      foreign_key :doctor_crm, :doctors, type: String
    end
  end
end
