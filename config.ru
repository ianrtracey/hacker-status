require 'sinatra'
require './app'
run Sinatra::Application

map "/scripts" do
  run Rack::Directory.new("./scripts/")
end
map "/stylesheets" do
  run Rack::Directory.new("./styles/")
end