class ApplicationController < ActionController::Base

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :authenticate_user!


	before_action :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :password])
	end

	def after_sign_in_path_for(resource)
    	stored_location_for(resource) || landing_upon_sign_in
  	end

  	private
  		def after_sign_out_path_for(resource)
    		stored_location_for(:user) || root_path
  		end

end

