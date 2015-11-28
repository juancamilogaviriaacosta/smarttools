module SessionHelper
	def log_in(user)
		session[:user_id] = user.id
	end
	
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	def current_user
		if @current_user.nil? && !session[:user_id].nil?
			@current_user = Administrator.find(session[:user_id])
		end
	end

	def logged_in?
		!session[:user_id].nil?
	end

end
