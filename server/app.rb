# frozen_string_literal: true

require 'sinatra/base'

class Application < Sinatra::Base
  get '/' do
    'Hello World'
  end
end
