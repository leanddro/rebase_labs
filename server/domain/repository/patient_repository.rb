# frozen_string_literal: true

module Repository
  class PatientRepository
    include Model

    def self.create_all(patients)
      existing_cpfs = DB[:patients].select_map(:cpf)
      new_patients = patients.reject { |patient| existing_cpfs.include?(patient['cpf']) }
      result = DB[:patients].multi_insert(new_patients)
      Result.success result
    rescue StandardError
      Result.failure('Erro ao tentar cadastrar pacientes')
    end
  end
end
