class HomeController < ApplicationController
	def index
		@page_title = "Home"
		@user = current_user
		@all_users = User.get_all_users @user
	end
end
