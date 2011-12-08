require 'sinatra'
require "sinatra/reloader" if development?

class ProgressiveApp < Sinatra::Base

  def simulate_delay
    sleep 1+rand(2)
  end

  def partial(template, options = {})
    erb template.to_sym, options.merge({:layout => false})
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    redirect "/pages/introduction"
  end

  get '/pages/:page' do |page|
    simulate_delay
    if request.xhr?
      partial page
    else
      erb page.to_sym, {:locals => {:page => page}}
    end
  end

end
