# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require './domain/model/patient'
require './domain/repository/patient_repository'

describe 'PatientRepository' do
  before do
    DB[:exam_items].delete
    DB[:exams].delete
    DB[:patients].delete
  end

  context 'create_all' do
    it 'deve salvar paciente' do
      model = Model::Patient.new name: 'nome paciente', cpf: '12345678901', email: 'paciente@email.com',
                                 birth_date: '10/01/2000', address: 'Endereço  paciente',
                                 city: 'São Paulo', state: 'São Paulo'

      result = Repository::PatientRepository.create_all [model.to_hash]
      patient = DB[:patients].first

      expect(result.success?).to be true
      expect(patient[:name]).to eq model.name
    end

    it 'deve retornar erro ao tentar salvar paciente sem cpf' do
      model = Model::Patient.new name: 'nome paciente', cpf: nil, email: 'paciente@email.com',
                                 birth_date: '10/01/2000', address: 'Endereço  paciente',
                                 city: 'São Paulo', state: 'São Paulo'

      result = Repository::PatientRepository.create_all [model.to_hash]
      count = DB[:patients].count

      expect(result.success?).to be false
      expect(count).to eq 0
    end
  end
end
