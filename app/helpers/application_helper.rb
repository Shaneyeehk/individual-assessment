module ApplicationHelper
	
	def logged_in
		session[:id] != nil
	end

	def current_user
		if logged_in
			@user ||= User.find_by(id: session[:id])
		end
	end
end
