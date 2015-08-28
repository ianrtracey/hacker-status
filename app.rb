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
  @users = User.all(:team_id => 7)
  content_type 'html'
  erb :index
end

get "/status/:username" do
  @user = User.get(1)
  content_type 'html'
  erb :status
end

get "/api/v1/teams" do
  @teams = Team.all
  @teams.to_json
end
get "/api/v1/teams/:id" do
  @team = Team.get(params[:id])
  @team.to_json
end

get "/api/v1/users" do
  @users = User.all
  @users.to_json
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
  @task.complete   	= params[:complete]
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

helpers do
  def pretty_category(category)
    case category
      when "ACTIVE"
        return '<div class="ui green horizontal label">Active</div>'
      when "BLOCKER"
        return '<div class="ui red horizontal label">Blocker</div>'
      when "COMPLETED"
        return '<div class="ui grey horizontal label">Completed</div>'
      else
    end
  end
end
