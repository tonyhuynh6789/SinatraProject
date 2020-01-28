class User < ActiveRecord::Base 
    has_secure_password
    has_many :favorites

    validates :username, :email, :password, presence: true 

    validates :email, uniqueness: true

    
# def slug
#     self.username.downcase.gsub(" ", "-")
#   end

#   def self.find_by_slug(slug)
#     User.all.find do |user|
#       user.slug == slug
#     end
#   end
end 