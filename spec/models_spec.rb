require 'rspec'
require 'data_mapper'
require '../models.rb'

DataMapper.setup(:default,"postgres://iantracey:Filly901secure@localhost/hacker-status-test")
DataMapper.finalize
DataMapper.auto_migrate!

describe 'Models' do

  def app
  	Sinatra::Application
  end

  it 'should run a simple test' do
  	get '/'
  	last_response.status.should == 200
  end
end