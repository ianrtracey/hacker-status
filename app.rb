require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'dm-postgres-adapter'
require File.dirname(__FILE__) + '/models.rb'
require 'json'
require 'Date'


before do
  content_type 'application/json'
end

get "/" do
  content_type 'html'
  erb :index
 end

get "/tasks" do
  @tasks = Task.all
  @tasks.to_json
end

post "/tasks/new" do
  @task = Task.new
  @task.complete 	= false
  @task.description = params[:description]
  @task.created_at 	= DateTime.now
  @task.updated_at  = nil
end

put "tasks/:id" do
  @task = Task.find(params[:id])
  @task.complete 	= params[:complete]
  @task.description = params[:description]
  @task.updated_at  = DateTime.now
  if @task.save
    {:task => @task, :status => "success"}.to_json
  else
  	{:task => @task, :status => "failure"}.to_json
  end
end

delete "task/:id" do
  @task = Task.find(params[:id])
  if @task.destroy
    {:task => @task, :status => "success"}.to_json
  else
  	{:task => @task, :status => "failure"}.to_json
  end
end

get "/getdate" do
  {:date => DateTime.now}.to_json
end
  