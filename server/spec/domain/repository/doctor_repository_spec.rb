# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require './domain/model/doctor'
require './domain/repository/doctor_repository'

describe 'DoctorRepository' do
  before do
    DB[:exam_items].delete
    DB[:exams].delete
    DB[:doctors].delete
  end

  context 'create_all' do
    it 'deve salvar medico' do
      model = Model::Doctor.new name: 'nome médico', crm: 'crm médico', crm_state: 'crm médico estado',
                                email: 'email médico'
      result = Repository::DoctorRepository.create_all [model.to_hash]
      doctor = DB[:doctors].first

      expect(result.success?).to be true
      expect(doctor[:name]).to eq model.name
    end

    it 'deve retornar erro ao tentar salvar medico sem crm' do
      model = Model::Doctor.new name: 'nome médico', crm: nil, crm_state: 'crm médico estado',
                                email: 'email médico'
      result = Repository::DoctorRepository.create_all [model.to_hash]
      count = DB[:doctors].count

      expect(result.success?).to be false
      expect(count).to eq 0
    end
  end
end
