# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require './domain/model/doctor'

describe 'Doctor' do
  context 'Deve retornar uma a classe Doctor' do
    it 'no formato model' do
      hash = { 'nome médico' => 'nome médico', 'crm médico' => 'crm médico',
               'crm médico estado' => 'crm médico estado', 'email médico' => 'email médico' }
      model = Model::Doctor.hash_to_model hash
      expect(model.class).to eq(Model::Doctor)
    end

    it 'no formato hash' do
      doctor = Model::Doctor.new(name: 'nome médico', crm: 'crm médico', crm_state: 'crm médico estado',
                                 email: 'email médico')
      hash = doctor.to_hash
      expect(hash.class).to eq(Hash)
    end
  end

  context 'Validar transformação do hash para model' do
    hash = { 'nome médico' => 'nome médico', 'crm médico' => 'crm médico',
             'crm médico estado' => 'crm médico estado', 'email médico' => 'email médico' }
    model = Model::Doctor.hash_to_model hash

    it 'nome igual ao hash' do
      expect(model.name).to eq(hash['nome médico'])
    end
    it 'crm igual ao hash' do
      expect(model.crm).to eq(hash['crm médico'])
    end
    it 'crm state igual ao hash' do
      expect(model.crm_state).to eq(hash['crm médico estado'])
    end
    it 'email igual ao hash' do
      expect(model.email).to eq(hash['email médico'])
    end
  end
end
