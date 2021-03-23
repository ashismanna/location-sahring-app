module ApplicationHelper
	def get_welcome_message(user)
		if action_name=="index" 
			"Welcome <strong>#{user.fullname}</strong> to Location Sharing App".html_safe
		elsif action_name=="show"
			"Location shared by <strong>#{user.fullname}</strong>".html_safe
		else
			""
		end
	end
end
