require 'sinatra'
require "sinatra/reloader" if development?

class ProgressiveApp < Sinatra::Base

  def simulate_delay
    # sleep 1+rand(2)
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    redirect "/pages/introduction"
  end

  get '/pages/:page' do |page|
    simulate_delay
    erb page.to_sym
  end

end
