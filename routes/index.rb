class App < Sinatra::Base

  # Index
  # -----------------------------------------------------------

  get '/' do
    slim :"index/index"
  end

end
