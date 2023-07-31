# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require './domain/model/exam'
require './domain/model/patient'
require './domain/model/doctor'
require './domain/repository/patient_repository'
require './domain/repository/doctor_repository'
require './domain/repository/exam_repository'

describe 'ExamRepository' do
  before do
    DB[:exam_items].delete
    DB[:exams].delete
    DB[:patients].delete
    DB[:doctors].delete
  end

  context 'create_all com sucesso' do
    it 'deve salvar exame' do
      DB[:patients].insert(Model::Patient.new(name: 'nome paciente', cpf: '12345678901', email: 'paciente@email.com',
                                              birth_date: Date.new(2000, 1, 10), address: 'Endereço  paciente',
                                              city: 'São Paulo', state: 'São Paulo').to_hash)

      DB[:doctors].insert(Model::Doctor.new(name: 'nome médico', crm: '123456', crm_state: 'crm médico estado',
                                            email: 'email médico').to_hash)

      model = Model::Exam.new token: 'a1b2c3d4', date: Date.new(2022, 1, 1), patient_cpf: '12345678901',
                              doctor_crm: '123456'

      result = Repository::ExamRepository.create_all [model.to_hash]
      exam = DB[:exams].first

      expect(result.success?).to be true
      expect(exam[:token]).to eq model.token
    end
  end
  context 'create_all com erro' do
    it 'deve retornar erro ao tentar salvar exame sem token' do
      DB[:patients].insert(Model::Patient.new(name: 'nome paciente', cpf: '12345678901', email: 'paciente@email.com',
                                              birth_date: Date.new(2000, 1, 10), address: 'Endereço  paciente',
                                              city: 'São Paulo', state: 'São Paulo').to_hash)

      DB[:doctors].insert(Model::Doctor.new(name: 'nome médico', crm: '123456', crm_state: 'crm médico estado',
                                            email: 'email médico').to_hash)

      model = Model::Exam.new token: nil, date: Date.new(2022, 1, 1), patient_cpf: '12345678901',
                              doctor_crm: '123456'

      result = Repository::ExamRepository.create_all [model.to_hash]
      count = DB[:exams].count

      expect(result.success?).to be false
      expect(count).to eq 0
    end

    it 'deve retornar erro ao tentar salvar exame para um medico não cadastrado' do
      DB[:patients].insert(Model::Patient.new(name: 'nome paciente', cpf: '12345678901', email: 'paciente@email.com',
                                              birth_date: Date.new(2000, 1, 10), address: 'Endereço  paciente',
                                              city: 'São Paulo', state: 'São Paulo').to_hash)

      model = Model::Exam.new token: 'a1b2c3d4', date: Date.new(2022, 1, 1), patient_cpf: '12345678901',
                              doctor_crm: '123456'

      result = Repository::ExamRepository.create_all [model.to_hash]
      count = DB[:exams].count

      expect(result.success?).to be false
      expect(count).to eq 0
    end

    it 'deve retornar erro ao tentar salvar exame para um paciente não cadastrado' do
      DB[:doctors].insert(Model::Doctor.new(name: 'nome médico', crm: '123456', crm_state: 'crm médico estado',
                                            email: 'email médico').to_hash)

      model = Model::Exam.new token: nil, date: Date.new(2022, 1, 1), patient_cpf: '12345678901',
                              doctor_crm: '123456'

      result = Repository::ExamRepository.create_all [model.to_hash]
      count = DB[:exams].count

      expect(result.success?).to be false
      expect(count).to eq 0
    end
  end
end
