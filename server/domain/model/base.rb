# frozen_string_literal: true

module Model
  class Base
    def initialize = raise 'Classe não pode ser instanciada'

    def to_hash
      instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete('@')] = instance_variable_get(var) }
    end
  end
end
