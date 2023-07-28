# frozen_string_literal: true

require 'sequel'
require './domain/model/result'

module Repository
  class ExamRepository
    include Model

    def self.create_all(exams)
      existing_tokens = DB[:exams].select_map(:token)
      new_exams = exams.reject { |exam| existing_tokens.include?(exam['token']) }
      _ = DB[:exams].multi_insert(new_exams)
      Result.success existing_tokens
    rescue StandardError
      Result.failure 'Erro ao tentar cadastrar exames'
    end

    def self.find_all
      Result.success DB[:exams].all
    rescue StandardError
      Result.failure 'Erro ao tentar buscar exames'
    end
  end
end
