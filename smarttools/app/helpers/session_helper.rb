module SessionHelper
	def log_in(user)
		session[:user_id] = user.id
	end
	
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	def current_user
		if !@current_user
			@current_user = Administrator.find(session[:user_id])
		end
	end

	def logged_in?
		!current_user.nil?
	end

end
