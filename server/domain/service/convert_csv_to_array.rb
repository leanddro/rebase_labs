# frozen_string_literal: true

require 'csv'
require './domain/model/result'

module Service
  class ConvertCSVToArray
    include Model

    def initialize(file)
      @file = file
    end

    def call
      CSV.foreach(@file, col_sep: ';', headers: true)
         .each_with_object([]) { |row, csv_data| csv_data << row.to_h }
         .yield_self { |rows| Result.success(rows) }
    rescue StandardError
      Result.failure("Erro ao tentar abrir arquivo: #{@file}")
    end
  end
end
