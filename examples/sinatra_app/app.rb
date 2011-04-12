# app.rb

require 'rubygems'
require 'sinatra/base'
require 'rack'
require 'yaml'
require 'erb'

class TestApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :static, true

  get '/:view' do |view|
    erb view.to_sym
  end
end

if __FILE__ == $0
  Rack::Handler::Mongrel.run TestApp, :Port => 8070
end
