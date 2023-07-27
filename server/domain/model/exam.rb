# frozen_string_literal: true

require_relative 'base'

module Model
  class Exam < Base
    def initialize(token:, date:, patient_cpf:, doctor_crm:)
      @token = token
      @date = date
      @patient_cpf = patient_cpf
      @doctor_crm = doctor_crm
    end

    def self.hash_to_model(hash)
      new(
        token: hash['token resultado exame'],
        date: hash['data exame'],
        patient_cpf: hash['cpf'],
        doctor_crm: hash['crm médico']
      )
    end
  end
end
