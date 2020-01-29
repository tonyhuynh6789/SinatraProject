class User < ActiveRecord::Base 
    has_secure_password
    has_many :favorites

    validates :username, :email, :password, presence: true 

    validates :email, :username, uniqueness: true


end 