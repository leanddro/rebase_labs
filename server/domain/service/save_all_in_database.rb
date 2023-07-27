# frozen_string_literal: true

require './domain/model/doctor'
require './domain/model/exam'
require './domain/model/exam_item'
require './domain/model/patient'
require './domain/model/result'
require './domain/repository/doctor_repository'
require './domain/repository/exam_repository'
require './domain/repository/exam_item_repository'
require './domain/repository/patient_repository'

module Service
  class SaveAllInDatabase
    include Model
    include Repository

    def initialize(all_data)
      @all_data = all_data
    end

    def call
      DB.transaction do
        DoctorRepository
          .create_all(to_doctors)
          .and_then { |_result| PatientRepository.create_all to_patients }
          .and_then { |_result| ExamRepository.create_all to_exams }
          .and_then { |result|  ExamItemRepository.create_all(to_exam_items, result) }
        Result.success('Dados cadastrado com sucesso')
      end
    rescue StandardError => e
      puts e
      Result.failure('Erro ao tentar cadastrar dados')
    end

    private

    def to_doctors
      @all_data.uniq { |data| data['crm médico'] }
               .map { |doctor_data| Doctor.hash_to_model(doctor_data).to_hash }
    end

    def to_patients
      @all_data.uniq { |data| data['cpf'] }
               .map { |patient_data| Patient.hash_to_model(patient_data).to_hash }
    end

    def to_exams
      @all_data.uniq { |data| data['token resultado exame'] }
               .map { |exams_data| Exam.hash_to_model(exams_data).to_hash }
    end

    def to_exam_items
      @all_data.map { |hash| ExamItem.hash_to_model(hash).to_hash }
    end
  end
end
