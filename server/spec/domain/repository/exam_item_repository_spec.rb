# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require './domain/model/exam'
require './domain/model/exam_item'
require './domain/model/patient'
require './domain/model/doctor'
require './domain/repository/exam_item_repository'

describe 'ExamRepository' do
  before do
    DB[:exam_items].delete
    DB[:exams].delete
    DB[:patients].delete
    DB[:doctors].delete
  end

  context 'create_all com sucesso' do
    it 'deve salvar item de exame' do
      DB[:patients].insert(Model::Patient.new(name: 'nome paciente', cpf: '12345678901', email: 'paciente@email.com',
                                              birth_date: Date.new(2000, 1, 10), address: 'Endereço  paciente',
                                              city: 'São Paulo', state: 'São Paulo').to_hash)

      DB[:doctors].insert(Model::Doctor.new(name: 'nome médico', crm: '123456', crm_state: 'crm médico estado',
                                            email: 'email médico').to_hash)

      DB[:exams].insert(Model::Exam.new(token: 'a1b2c3d4', date: Date.new(2022, 1, 1), patient_cpf: '12345678901',
                                        doctor_crm: '123456').to_hash)

      model = Model::ExamItem.new type: 'exame', limits_between: '10-30', result: '25', exam_token: 'a1b2c3d4'

      result = Repository::ExamItemRepository.create_all [model.to_hash], ['a1b2c3']
      exam = DB[:exam_items].first

      expect(result.success?).to be true
      expect(exam[:type]).to eq model.type
    end

    it 'deve retornar erro ao tentar salvar exame sem token de exame' do
      DB[:patients].insert(Model::Patient.new(name: 'nome paciente', cpf: '12345678901', email: 'paciente@email.com',
                                              birth_date: Date.new(2000, 1, 10), address: 'Endereço  paciente',
                                              city: 'São Paulo', state: 'São Paulo').to_hash)

      DB[:doctors].insert(Model::Doctor.new(name: 'nome médico', crm: '123456', crm_state: 'crm médico estado',
                                            email: 'email médico').to_hash)

      DB[:exams].insert(Model::Exam.new(token: 'a1b2c3d4', date: Date.new(2022, 1, 1), patient_cpf: '12345678901',
                                        doctor_crm: '123456').to_hash)

      model = Model::ExamItem.new type: 'exame', limits_between: '10-30', result: '25', exam_token: 'a1b2c3d4'

      _result = Repository::ExamItemRepository.create_all [model.to_hash], ['a1b2c3d4']
      count = DB[:exam_items].count

      expect(count).to eq 0
    end
  end
end
