# frozen_string_literal: true

require 'rspec'
require './domain/model/exam'
require './domain/repository/exam_repository'

describe 'ExamRepository' do
  before do
    DB[:exam_items].delete
    DB[:exams].delete
    DB[:patients].delete
    DB[:doctors].delete
  end

  context 'find_by_token' do
    it 'retorna dados com sucesso' do
      DB[:patients].insert(Model::Patient.new(name: 'nome paciente', cpf: '12345678901', email: 'paciente@email.com',
                                              birth_date: Date.new(2000, 1, 10), address: 'Endereço  paciente',
                                              city: 'São Paulo', state: 'São Paulo').to_hash)
      DB[:doctors].insert(Model::Doctor.new(name: 'nome médico', crm: '123456', crm_state: 'crm médico estado',
                                            email: 'email médico').to_hash)
      DB[:exams].insert Model::Exam.new(token: 'a1b2c3d4', date: Date.new(2022, 1, 1), patient_cpf: '12345678901',
                                        doctor_crm: '123456').to_hash
      DB[:exam_items].multi_insert [
        Model::ExamItem.new(type: 'exame-1', limits_between: '10-30', result: '25', exam_token: 'a1b2c3d4').to_hash,
        Model::ExamItem.new(type: 'exame-2', limits_between: '5-12', result: '15', exam_token: 'a1b2c3d4').to_hash,
        Model::ExamItem.new(type: 'exame-3', limits_between: '20-35', result: '34', exam_token: 'a1b2c3d4').to_hash
      ]

      result = Repository::ExamRepository.find_by token: 'a1b2c3d4'

      expect(result.success?).to be true
      expect(result.value[:token]).to eq 'a1b2c3d4'
      expect(result.value[:patient_cpf]).to eq '12345678901'
      expect(result.value[:doctor][:name]).to eq 'nome médico'
      expect(result.value[:patient][:name]).to eq 'nome paciente'

      expect(result.value[:exam_items].count).to eq 3
    end

    it 'retorna array vazio' do
      result = Repository::ExamRepository.find_by token: 'a1b2c3d4'

      expect(result.success?).to be false
      expect(result.value.nil?).to be true
    end
  end
end
