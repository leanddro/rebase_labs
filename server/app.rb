# frozen_string_literal: true

require 'sinatra'
require './config/sequel'

configure do
  DB = Config::Database.instance
end

class Application < Sinatra::Base
  require './app/controllers/exam_controller'
  use Controller::ExamController
end
