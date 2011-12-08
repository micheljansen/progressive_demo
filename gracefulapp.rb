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

  get '/pages/:page' do |page|
    sleep 1
    erb :index, :locals => {:page => page}
  end

  get '/partials/:partial' do |page|
    sleep 1
    partial page
  end

end
