require 'sinatra'
require "sinatra/reloader" if development?

class GracefulApp < Sinatra::Base

  def partial(partial)
    erb "_#{partial}".to_sym
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/page/:partial' do |page|
    partial page
  end

  get '/:page' do |page|
    erb :index, :locals => {:page => page}
  end

end
