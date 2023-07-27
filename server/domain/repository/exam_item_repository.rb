# frozen_string_literal: true

module Repository
  class ExamItemRepository
    include Model

    def self.create_all(exam_items, existing_tokens)
      new_exam_items = exam_items.reject { |exam_item| existing_tokens.include?(exam_item['exam_token']) }
      DB[:exam_items].multi_insert(new_exam_items)
      Result.success
    rescue StandardError
      Result.failure('Erro ao tentar cadastrar itens ao exame')
    end
  end
end
