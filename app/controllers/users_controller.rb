class UsersController < ApplicationController

	before_action :logged_in_user, only: [:edit, :update, :show]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy
	#renders a page for a user to signup
	def new
		@user = User.new
	end

	#to save a new user to the database, the new method doesn't save the user to the database
	def create
		@user = User.new(user_params)
		if @user.save
			#this will be changed later to send an activation email to the user to activate his account
			flash[:success] = "User saved successfully"
			redirect_to root_url #modify it to redirect to th requesting url
		else
			render 'new'
		end
	end

	def edit
		@user =  User.find_by(id: params[:id])
	end

	def show
	end

	def update
		@user = User.find_by(id: params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated successfully"
			redirect_to root_url
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
  		flash[:success] = "User deleted"
  		redirect_to root_url #do an index page for users that only the admin can see, and delete as need be
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	#used to ensure that a user can only do some stuff if he is logged in. For the stuff, they can do, look at line 3
	def logged_in_user
		unless logged_in?
			store_location #this stores the url of the page the user was on when they tried to perform an action that required them logging in first
			flash.now[:danger] = "Please log in"
			redirect_to login_url
		end
	end

	#this method prevents a user from editing another user's information. It uses the id in session to find a user 
	#and store it in an @user variable, and compare it against the user in the current_user variable
	def correct_user
		@user = User.find_by(id: params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end

	 def admin_user
      redirect_to(root_url) unless current_user.admin?    
    end
end
