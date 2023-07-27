# frozen_string_literal: true

require_relative 'base'

module Model
  class ExamItem < Base
    def initialize(type:, limits_between:, result:, exam_token:)
      @type = type
      @limits_between = limits_between
      @result = result
      @exam_token = exam_token
    end

    def self.hash_to_model(hash)
      new(
        type: hash['tipo exame'],
        limits_between: hash['limites tipo exame'],
        result: hash['resultado tipo exame'],
        exam_token: hash['token resultado exame']
      )
    end
  end
end
