require 'sinatra'
require 'json'
require "sinatra/reloader" if development?

class ProgressiveApp < Sinatra::Base

  def simulate_delay
    sleep 1+rand(2)
  end

  def partial(template, options = {})
    erb template.to_sym, options.merge({:layout => false})
  end

  helpers do
    def js(towrap)
      "<%= #{towrap} %>"
    end
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

  get '/books' do
    order_by = params[:order].to_sym

    books = {
      1 => {
        :id => 1,
        :title => "Adventures of Huckleberry Finn",
        :author => {:first => "Mark", :last => "Twain"},
        :year => 1884
      },
      2 => {
        :id => 2,
        :title => "The Adventures of Sherlock Holmes",
        :author => {:first => "Sir Arthur", :last =>"Conan Doyle"},
        :year => 1859
      },
      3 => {
        :id => 3,
        :title => "Ulysses",
        :author => {:first => "James", :last => "Joyce"},
        :year => 1922
      },
      4 => {
        :id => 4,
        :title => "Alice's Adventures in Wonderland",
        :author => {:first => "Lewis", :last => "Carroll"},
        :year => 1865
      }
    }

    results = []
    if(order_by == :author)
      results = books.values.sort do |a,b|
        a[:author][:last] <=> b[:author][:last]
      end
    else
      results = books.values.sort do |a,b|
        a[order_by] <=> b[order_by]
      end
    end

    results_json = results.to_json

    erb :books, :locals => {:page => "Books", 
                            :books => results, 
                            :results_json => results_json}
  end

  # legacy route, so you can see the output without having to do an XHR
  get '/partials/:page' do |page|
    partial page
  end

end
