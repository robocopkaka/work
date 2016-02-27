class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper #this allows me use all the methods in the sessions helper in all my controllers

   def user_id
    @logged_in_user = User.find_by(id: params[:id])
    @user_id = @logged_in_user.id
   end
  private
  def logged_in_user
  	unless logged_in?
  		store_location
  		flash[:danger] = "Please Log in"
  		redirect_to login_url #remember to create a login route after adding a create method to the sessions controller
  	end
  end
end
