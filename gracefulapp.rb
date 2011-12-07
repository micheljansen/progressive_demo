require 'sinatra'
require "sinatra/reloader" if development?

class GracefulApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end
end
