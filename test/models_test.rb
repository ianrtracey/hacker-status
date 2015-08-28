require File.expand_path '../../app.rb', __FILE__
require 'minitest/autorun'
require 'rack/test'

class ModelsTest < Minitest::Test

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def count
    assert_equal(User.all.count, 1)
  end

  def user
      puts "Testing users"
      DataMapper.auto_migrate!
      @team = Team.create(:name => "Hack Arizona")
      # Can create a User that belongs to a team
      @user = User.create(:name => "Ian", :username => "ian",
                          :password => "secret", :email => "ianrtracey@gmail.com", :team_id => @team.id)
      assert_equal User.all.count, 4, "User not created"
  end




end