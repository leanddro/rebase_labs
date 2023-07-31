# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require './domain/model/exam'

describe 'Exam' do
  context 'Deve retornar uma a classe Exam' do
    it 'no formato model' do
      hash = { 'token resultado exame' => 'ad541a', 'data exame' => '2018-01-01', 'cpf' => '12345678901',
               'crm médico ' => '123456789' }
      model = Model::Exam.hash_to_model hash
      expect(model.class).to eq(Model::Exam)
    end
    it 'no formato hash' do
      model = Model::Exam.new(token: 'ad541a', date: '2018-01-01', patient_cpf: '12345678901', doctor_crm: '123456789')
      hash = model.to_hash
      expect(hash.class).to eq(Hash)
    end
  end
  context 'Validar transformação do hash para model' do
    hash = { 'token resultado exame' => 'ad541a', 'data exame' => '2018-01-01', 'cpf' => '12345678901',
             'crm médico ' => '123456789' }
    model = Model::Exam.hash_to_model hash

    it 'token igual ao hash' do
      expect(model.token).to eq(hash['token resultado exame'])
    end
    it 'data igual ao hash' do
      expect(model.date).to eq(hash['data exame'])
    end
    it 'cpf igual ao hash' do
      expect(model.patient_cpf).to eq(hash['cpf'])
    end
    it 'crm medico igual ao hash' do
      expect(model.doctor_crm).to eq(hash['crm médico'])
    end
  end
end
