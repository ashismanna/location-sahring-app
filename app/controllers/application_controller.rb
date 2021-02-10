class ApplicationController < ActionController::Base

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception


	before_action :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :password])
	# devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) } # The :firstname and :lastname are my custom fields.
	end
end

