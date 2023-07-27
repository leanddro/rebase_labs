# frozen_string_literal: true

require_relative 'base'

module Model
  class Patient < Base
    def initialize(name:, cpf:, email:, birth_date:, address:, city:, state:)
      @name = name
      @cpf = cpf
      @email = email
      @birth_date = birth_date
      @address = address
      @city = city
      @state = state
    end

    def self.hash_to_model(hash)
      new(
        name: hash['nome paciente'],
        cpf: hash['cpf'],
        email: hash['email paciente'],
        birth_date: hash['data nascimento paciente'],
        address: hash['endereço/rua paciente'],
        city: hash['cidade paciente'],
        state: hash['estado patiente"']
      )
    end
  end
end
