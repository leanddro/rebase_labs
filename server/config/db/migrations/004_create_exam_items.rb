# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:exam_items) do
      primary_key :id
      String :type
      String :limits_between
      String :result
      foreign_key :exam_token, :exams, type: String
    end
  end
end
