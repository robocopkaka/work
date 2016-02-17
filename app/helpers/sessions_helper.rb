module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id
	end

	#this method finds if there's already a current user in the session, i.e. i visit a page, and navigate to another page, if 
	#not, it assigns the user's session id to the @current_user variable, and can be used to retrieve the current user's details from the db
	#eg. instead of doing user =  User.find... and user.name to get the user's name, we could just do current_user.name
	def current_user
		if(user_id = session[:user_id]) #checking if session of user_id exists while setting session of user_id to user_id
			@current_user || User.find_by(id: user_id)
		elsif(user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	def logged_in?
		!current_user.nil? # this is to return true if there's a user in the session, and false, otherwise, current_user.nil
						   # would return false if there was a user, using '!' turns the false to true
	end

	#to destroy a session once the user logs out
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	#this persists the user in the database using the cookies method. it also makes use of the remember method defined in the User model
	#to generate a remember_token encrypt it, and save the encrypted value in the remember_digest field for the user
	def remember(user)
		user.remember
		cookies.signed.permanent[:user_id] = user.id
		cookies.signed.permanent[:remember_token] = user.remember_token
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	#this checks if the user trying to do something is actually the logged in user, returns true if it is
	def current_user?(user)
		current_user == user
	end

	#this redirects the user to the page he was on before or to the root_url
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	#this stores the location of the page the user was on
	def store_location
		session[:forwarding_url] = request.url if request.get?
	end
end
