# frozen_string_literal: true

require 'rspec'
require './domain/service/convert_csv_to_array'
require './domain/service/save_all_in_database'

describe 'SaveAllInDatabase' do
  before do
    DB[:exam_items].delete
    DB[:exams].delete
    DB[:patients].delete
    DB[:doctors].delete
  end

  context 'call' do
    it 'salva dados do array em banco de dados' do
      result = Service::ConvertCSVToArray.new('spec/data/data.csv')
                                         .call
                                         .and_then { |data| Service::SaveAllInDatabase.new(data).call }

      exam_item_count = DB[:exam_items].count
      exam_count = DB[:exams].count
      patient_count = DB[:patients].count
      doctor_count = DB[:doctors].count

      expect(result.success?).to be true
      expect(exam_item_count).to eq 1
      expect(exam_count).to eq 1
      expect(patient_count).to eq 1
      expect(doctor_count).to eq 1
    end

    it 'retorna erro quando arquivo não existe' do
      result = Service::ConvertCSVToArray.new('spec/data/datttta.csv')
                                         .call
                                         .and_then { |data| Service::SaveAllInDatabase.new(data).call }

      exam_item_count = DB[:exam_items].count
      exam_count = DB[:exams].count
      patient_count = DB[:patients].count
      doctor_count = DB[:doctors].count

      expect(result.success?).to be false
      expect(exam_item_count).to eq 0
      expect(exam_count).to eq 0
      expect(patient_count).to eq 0
      expect(doctor_count).to eq 0
    end
  end
end
