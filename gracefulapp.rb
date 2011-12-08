require 'sinatra'
require "sinatra/reloader" if development?

class GracefulApp < Sinatra::Base

  def simulate_delay
    sleep 1+rand(2)
  end

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
    simulate_delay
    erb :index, :locals => {:page => page}
  end

  get '/partials/:partial' do |page|
    simulate_delay
    partial page
  end

end
