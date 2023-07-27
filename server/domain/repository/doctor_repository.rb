# frozen_string_literal: true

require './domain/model/result'

module Repository
  class DoctorRepository
    include Model

    def self.create_all(doctors)
      existing_crms = DB[:doctors].select_map(:crm)
      new_doctors = doctors.reject { |doctor| existing_crms.include?(doctor['crm']) }
      result = DB[:doctors].multi_insert(new_doctors)
      Result.success result
    rescue StandardError
      Result.failure('Erro ao tentar cadastrar medicos')
    end
  end
end
