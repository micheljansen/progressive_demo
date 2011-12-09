require 'sinatra'
require 'json'
require "sinatra/reloader" if development?
require "jsmock"

class ProgressiveApp < Sinatra::Base

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


  def simulate_delay
    sleep 1+rand(2)
  end


  helpers do
    def partial(template, options = {})
      erb template.to_sym, options.merge({:layout => false})
    end
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    redirect "/books"
  end

  get '/books:format?' do |format|
    order_by = params[:order].nil? ? :title : params[:order].to_sym

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

    if(format == ".json") 
      results_json
    else
      erb :books, :locals => {:page => "Books", 
                              :books => results, 
                              :results_json => results_json}
    end
  end
end
