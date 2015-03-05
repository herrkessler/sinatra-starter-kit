# encoding: utf-8

require 'bundler'
Bundler.require
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/assetpack'
require "sinatra/reloader"
require 'sinatra/contrib'
require "sinatra/cookies"
require 'will_paginate'
require 'will_paginate/data_mapper'
require 'json'
require 'thin'
require "gravatarify"

require './model'

class App < Sinatra::Base

  # -----------------------------------------------------------
  # Sinatra Settings
  # -----------------------------------------------------------

  set :root, File.dirname(__FILE__)
  set :environments, %w{development production}
  set :session_secret, '*&(^B234'
  set :public_folder, 'public'
  set :server, 'thin'

  enable :sessions
  enable :method_override
  enable :logging

  register Sinatra::Flash
  register Sinatra::AssetPack
  register Sinatra::Contrib

  # -----------------------------------------------------------
  # Assets
  # -----------------------------------------------------------

  require 'sass'
  set :sass, { :load_paths => [ "#{App.root}/assets/css" ] }

  assets do
    serve '/js',     from: 'assets/js'        # Default
    serve '/css',    from: 'assets/css'       # Default
    serve '/images', from: 'assets/images'    # Default
    serve '/fonts',  from: 'assets/fonts'     # Default

    js :application, [
      '/js/lib/jquery-2.1.3.js',
      '/js/vendor/jquery.cookie.js',
      '/js/specific/app.js',
    ]

    css :application, '/css/application.sass', [
      '/css/application.css'
    ]

    js_compression  :jsmin
    css_compression :sass 
  end

  # -----------------------------------------------------------
  # Helpers
  # -----------------------------------------------------------

  helpers WillPaginate::Sinatra::Helpers
  helpers Sinatra::Cookies

  helpers do

    def paginate(collection)
       options = {
         inner_window: 0,
         outer_window: 0,
         previous_label: '&laquo;',
         next_label: '&raquo;'
       }
      will_paginate collection, options
    end

    def truncate_words(text, length, end_string = ' ...')
      words = text.split()
      words = words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
    end

  end

  # -----------------------------------------------------------
  # Routes
  # -----------------------------------------------------------

  require_relative 'routes/index'
  require_relative 'routes/user'

end