class User < ActiveRecord::Base
	before_save :downcase_email
	validates :name, presence:true, length:{maximum:50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:true, format:{with:VALID_EMAIL_REGEX}, uniqueness:{case_sensitive:false}
	has_secure_password #this generates an encrypted password and requires a password_digest attribute in the table
	validates :password, length:{minimum:6}, allow_blank:true

	attr_accessor :remember_token

	#this generates a random new token, that will be used for activation and remember tokens
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	#creates encrypted digests/strings using the Bcrypt gem
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	#this is used to hash the remember token which is to be passed to the cookies method to keep track of a user, and store 
	#the hashed value in the remember_digest table of the database
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	#this removes the remember_digest from the database, hence forgetting the user. It deletes the session and cookies variables that have been created
	def forget
		update_attribute(:remember_digest, nil)
	end
	#this is going to be used to check if the remember_token, when hashed, is the same as the remember_digest for a particular user
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	private

	def downcase_email
		self.email = email.downcase
	end
end
