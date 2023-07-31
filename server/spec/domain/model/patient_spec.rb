# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require './domain/model/patient'

describe ' Patient' do
  context 'Deve retornar uma a classe Patient' do
    it 'no formato model' do
      hash = { 'nome paciente' => 'nome paciente', 'cpf' => '12345678901',
               'email paciente' => 'paciente@email.com',
               'data nascimento paciente' => '10/01/2000', 'endereço/rua paciente' => 'Endereço  paciente',
               'cidade paciente' => 'São Paulo', 'estado patiente' => 'São Paulo' }
      model = Model::Patient.hash_to_model hash
      expect(model.class).to eq(Model::Patient)
    end
    it 'no formato hash' do
      model = Model::Patient.new(
        name: 'nome paciente',
        cpf: '12345678901',
        email: 'paciente@email.com',
        birth_date: '10/01/2000',
        address: 'Endereço  paciente',
        city: 'São Paulo',
        state: 'São Paulo'
      )
      hash = model.to_hash
      expect(hash.class).to eq(Hash)
    end
  end

  context 'Validar transformação do hash para model' do
    hash = { 'nome paciente' => 'nome paciente', 'cpf' => '12345678901',
          'email paciente' => 'paciente@email.com','data nascimento paciente' => '10/01/2000',
          'endereço/rua paciente' => 'Endereço  paciente', 'cidade paciente' => 'São Paulo', 
          'estado patiente' => 'São Paulo' }
    model = Model::Patient.hash_to_model hash

    it 'nome igual ao hash' do
      expect(model.name).to eq(hash['nome paciente'])
    end
    it 'cpf igual ao hash' do
      expect(model.cpf).to eq(hash['cpf'])
    end
    it 'email igual ao hash' do
      expect(model.email).to eq(hash['email paciente'])
    end
    it 'data igual ao hash' do
      expect(model.birth_date).to eq(hash['data nascimento paciente'])
    end
    it 'endereço igual ao hash' do
      expect(model.address).to eq(hash['endereço/rua paciente'])
    end
    it 'cidade igual ao hash' do
      expect(model.city).to eq(hash['cidade paciente'])
    end
    it 'estado igual ao hash' do
      expect(model.state).to eq(hash['estado patiente'])
    end
  end
end
