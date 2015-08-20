require 'ffaker'
class Seeder

USERBASE_SIZE = 500

	def initialize
		puts "Seeding..."
		seed_teams
		seed_users
		seed_statuses
		puts "Seeding complete."
		puts "Number of Teams #{Team.count}"
		puts "Number of Users #{User.count}"
		puts "Number of Statuses #{Status.count}"
	end

private
	def seed_teams
		team_size = USERBASE_SIZE/rand(5..20).ceil
		team_size.times do 
			Team.create(:name => FFaker::Company.name)
		end
	end

	def seed_users
		USERBASE_SIZE.times do
			User.create(:name => FFaker::Internet.user_name, :email => FFaker::Internet.email,
			:password => "secret", :team_id => rand(1..Team.count) )
		end
	end

	def seed_statuses
		User.all.each do |user|
			num_of_statuses = rand(0..15)
			num_of_statuses.times do
			  status = Status.create(:user_id => user.id)
			  	num_of_items = rand(1..10)
			  	num_of_items.times do
			  	  Item.create(:category => ["ACTIVE", "COMPLETED", "BLOCKER"].sample, 
				  :content => FFaker::Lorem.sentence, :status_id => status.id)
			  	end
			end
		end
	end

end