class HomeController < ApplicationController
	def index
		@page_title = "Home"
		@all_users = User.get_all_users current_user
	end
end
