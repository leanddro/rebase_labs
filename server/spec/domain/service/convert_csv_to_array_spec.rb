# frozen_string_literal: true

require 'rspec'
require './domain/service/convert_csv_to_array'

describe 'ConvertCSVToArray' do
  context 'call' do
    it 'retorna um array de hash como os dados do arquivo csv' do
      result = Service::ConvertCSVToArray.new('spec/data/data.csv').call
      expect(result.success?).to be true
    end

    it 'retorna erro quando arquivo não existe' do
      result = Service::ConvertCSVToArray.new('spec/data/datttta.csv').call

      expect(result.success?).to be false
    end

    it 'e o hash tem os valores validos' do
      result = Service::ConvertCSVToArray.new('spec/data/data.csv').call

      expect(result.value[0]['nome paciente']).to eq 'Emilly Batista Neto'
    end
  end
end
