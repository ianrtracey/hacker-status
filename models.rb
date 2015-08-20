DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://iantracey:Filly901secure@localhost/hacker-status")

class Team
  include DataMapper::Resource

  property :id,			Serial
  property :name, 	    String, :required => true, :unique => true, :length => 1..50 
  property :created_at,	DateTime
  
  has n, :users
		
end

class User
  include DataMapper::Resource

  property :id,		   Serial
  property :email,     String, :required => true, :length => 1..100, :unique => true,
  	:format => :email_address,
  	:messages => {
  		:presence => "Please include an email",
  		:is_unique => "Email already taken",
  		:format => "Invalid email address format"
  	}
  property :password,  String, :length => 100
  property :name,	   String, :length => 100

  has n, :statuses
  belongs_to :team
end

class Status
  include DataMapper::Resource
  
  property :id,		   Serial
  property :created_at,DateTime
  property :updated_at,DateTime

  has n, :items
  belongs_to :user
end

class Item
  include DataMapper::Resource

  validates_with_method :is_valid_category

  property :id,  		Serial
  property :category,   String, :length => 1..50, :required => true
  property :content,    String, :length => 1..140, :required => true

  belongs_to :status

  def is_valid_category
  	if !self.category.include?("ACTIVE" || "COMPLETED" || "BLOCKER")
  	  return [ false, "Invalid category type" ]
  	else
  	  return true
    end
  end
end
DataMapper.auto_upgrade!