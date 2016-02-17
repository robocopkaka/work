class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			params[:session][:remember_me] == '1' ? remember(user) : forget(user) #if the user clicks the remember me checkbox, the value for remember_me becomes 1
			redirect_back_or user
		else
			flash.now[:danger] = "Invalid Password/ Email Combination"
			render 'new'
		end
	end

	def destroy
		log_out if logged_in?
		redirect_to root_url
	end
end
