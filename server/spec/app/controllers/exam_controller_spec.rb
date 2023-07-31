# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require './app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  before do
    DB[:exam_items].delete
    DB[:exams].delete
    DB[:patients].delete
    DB[:doctors].delete
  end

  context 'GET to /api/exams' do
    let(:response) { get '/api/exams' }

    it 'deve retornar 200' do
      expect(response.status).to eq 200
    end

    it 'deve retornar array vazio' do
      expect(response.body).to eq '{"success":true,"data":[]}'
    end

    it 'deve retornar array com dois elemento' do
      DB[:patients].insert(Model::Patient.new(name: 'nome paciente', cpf: '12345678901', email: 'paciente@email.com',
                                              birth_date: Date.new(2000, 1, 10), address: 'Endereço  paciente',
                                              city: 'São Paulo', state: 'São Paulo').to_hash)
      DB[:doctors].insert(Model::Doctor.new(name: 'nome médico', crm: '123456', crm_state: 'crm médico estado',
                                            email: 'email médico').to_hash)
      DB[:exams].multi_insert([
                                Model::Exam.new(token: 'a1b2c3d4', date: Date.new(2022, 1, 1),
                                                patient_cpf: '12345678901', doctor_crm: '123456').to_hash,
                                Model::Exam.new(token: 'b1c2d3e4', date: Date.new(2022, 5, 1),
                                                patient_cpf: '12345678901', doctor_crm: '123456').to_hash
                              ])
      response = get '/api/exams'

      expect(response.body).to eq '{"success":true,"data":[{"token":"a1b2c3d4","date":"2022-01-01","patient_cpf":"12345678901","doctor_crm":"123456"},{"token":"b1c2d3e4","date":"2022-05-01","patient_cpf":"12345678901","doctor_crm":"123456"}]}'
    end
  end
end
