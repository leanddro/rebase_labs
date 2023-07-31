# frozen_string_literal: true

require_relative 'base'

module Model
  class Doctor < Base
    attr_accessor :name, :crm, :crm_state, :email

    def initialize(name:, crm:, crm_state:, email:)
      @name = name
      @crm = crm
      @crm_state = crm_state
      @email = email
    end

    def self.hash_to_model(hash)
      new(name: hash['nome médico'],
          crm: hash['crm médico'],
          crm_state: hash['crm médico estado'],
          email: hash['email médico'])
    end
  end
end
