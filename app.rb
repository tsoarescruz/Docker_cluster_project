require 'sinatra'
require "sinatra/json"
require './workers/google'

get '/' do
  worker_response = GoogleWorker.run params['q']

  json worker_response
end
