# frozen_string_literal: true

require 'sinatra/base'
require './domain/repository/exam_repository'

module Controller
  class ExamController < Sinatra::Base
    include Repository

    get '/api/exams' do
      result = ExamRepository.find_all
      status 400 unless result.success?
      { success: result.success?, data: result.value }.to_json
    end

    get '/exams' do
      File.open('public/exames.html')
    rescue StandardError => e
      puts e
    end
  end
end
