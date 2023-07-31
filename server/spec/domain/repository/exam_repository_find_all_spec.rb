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

  context 'find_all' do
    it 'retorna dados com sucesso' do
      DB[:patients].insert(Model::Patient.new(name: 'nome paciente', cpf: '12345678901', email: 'paciente@email.com',
                                              birth_date: Date.new(2000, 1, 10), address: 'Endereço  paciente',
                                              city: 'São Paulo', state: 'São Paulo').to_hash)
      DB[:doctors].insert(Model::Doctor.new(name: 'nome médico', crm: '123456', crm_state: 'crm médico estado',
                                            email: 'email médico').to_hash)
      DB[:exams].insert Model::Exam.new(token: 'a1b2c3d4', date: Date.new(2022, 1, 1), patient_cpf: '12345678901',
                                        doctor_crm: '123456').to_hash
      result = Repository::ExamRepository.find_all

      expect(result.success?).to be true
      expect(result.value[0][:token]).to eq 'a1b2c3d4'
    end

    it 'retorna array vazio' do
      result = Repository::ExamRepository.find_all

      expect(result.success?).to be true
      expect(result.value.empty?).to be true
    end
  end
end
