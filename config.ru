require 'sinatra'
require './app'
run Sinatra::Application

map "/scripts" do
  run Rack::Directory.new("./scripts/")
end
map "/semantic" do
  run Rack::Directory.new("./node_modules/semantic-ui/dist")
end
map "/components" do
  run Rack::Directory.new("./bower_components/")
end
map "/stylesheets" do
  run Rack::Directory.new("./styles/")
end