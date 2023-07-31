# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require './domain/model/exam_item'

describe 'ExamItem' do
  context 'Deve retornar uma a classe ExamItem' do
    it 'no formato model' do
      hash = { 'tipo exame' => 'tipo exame', 'limites tipo exame' => '10-20', 'resultado tipo exame' => '15',
               'token resultado exame' => 'ad541a' }
      model = Model::ExamItem.hash_to_model hash
      expect(model.class).to eq(Model::ExamItem)
    end

    it 'no formato hash' do
      exam_item = Model::ExamItem.new(type: 'tipo exame', limits_between: '10-20', result: '15', exam_token: 'ad541a')
      hash = exam_item.to_hash
      expect(hash.class).to eq(Hash)
    end
  end

  context 'Validar transformação do hash para model' do
    hash = { 'tipo exame' => 'tipo exame', 'limites tipo exame' => '10-20', 'resultado tipo exame' => '15',
             'token resultado exame' => 'ad541a' }
    model = Model::ExamItem.hash_to_model hash

    it 'tipo igual ao hash' do
      expect(model.type).to eq(hash['tipo exame'])
    end
    it 'limites igual ao hash' do
      expect(model.limits_between).to eq(hash['limites tipo exame'])
    end
    it 'resultado igual ao hash' do
      expect(model.result).to eq(hash['resultado tipo exame'])
    end
    it 'token igual ao hash' do
      expect(model.exam_token).to eq(hash['token resultado exame'])
    end
  end
end
