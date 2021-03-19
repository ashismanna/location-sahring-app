class UsersController < ApplicationController
	before_action :find_user,:only => [:show]
	
	def get_all_latlong_details
		all_public_shared_locations = (params[:username] and params[:username].present?) ? User.find_by_username(params[:username]).get_public_locations : current_user.get_public_locations(true)
		all_location_shared_with_current_user = current_user.get_location_shared_with_current_user

		all_public_shared_locations_hash = Hash.new
		all_location_shared_with_current_user_hash = Hash.new


		all_public_shared_locations.each_with_index{ |location,index| all_public_shared_locations_hash["public_location_#{index+1}"] = {
			"lon" => location.longitude,
			"lat" => location.latitude
			}
    	}
    	all_location_shared_with_current_user.each_with_index{ |location,index| all_location_shared_with_current_user_hash["location_been_shared_#{index+1}"] = {
			"lon" => location.longitude,
			"lat" => location.latitude
			}
    	}

    	data = {
    		"public_shared_locations" => all_public_shared_locations_hash,
    		"location_shared_with_user" => all_location_shared_with_current_user_hash
    	}

        respond_to do |format|
          format.json{render :json=>data}
        end
	end

	def show
		@page_title = "User Page"
	end

	private

	def find_user
		@user = User.find_by_username(params[:id]) or raise(ActiveRecord::RecordNotFound) if params[:id]
	end
end
