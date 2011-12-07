require 'sinatra'
require "sinatra/reloader" if development?

class GracefulApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/page/:partial' do |partial|
    erb partial
  end

  get '/:page' do |page|
    erb :index, :locals => {:partial => page}
  end

end
