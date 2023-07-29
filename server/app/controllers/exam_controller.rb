# frozen_string_literal: true

require 'sinatra/base'
require './domain/repository/exam_repository'
require './app/workers/exams_importer'
require './domain/service/convert_csv_to_array'

module Controller
  class ExamController < Sinatra::Base
    include Repository
    include Worker
    include Service

    get '/api/exams' do
      result = ExamRepository.find_all
      if result.failure?
        status 500
        return { success: result.success?, data: result.error }.to_json
      end
      { success: result.success?, data: result.value }.to_json
    end

    get '/api/exams/:token' do
      result = ExamRepository.find_by token: params['token']
      if result.failure?
        status 400
        return { success: result.success?, data: result.error }.to_json
      end
      { success: result.success?, data: result.value }.to_json
    end

    post '/api/exams/import' do
      csv_array = ConvertCSVToArray
                  .new(params[:file][:tempfile])
                  .call
      ExamsImporter.perform_async(csv_array.value)
      { data: 'processando...' }.to_json
    end

    get '/exams' do
      File.open('public/exams.html')
    rescue StandardError => e
      puts e
    end

    get '/exams/:token' do
      File.open('public/exam_details.html')
    rescue StandardError => e
      puts e
    end
  end
end
