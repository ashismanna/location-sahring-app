class HomeController < ApplicationController
	def index
		@page_title = "Home"
		@all_users = User.get_all_users current_user
	end

	def get_all_latlong_for_current_user
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

	def user_show
		@page_title = "User Page"
		user = User.find_by_username(params[:username])
	end

	def share_location
		@page_title = "Share Location"
		@all_users = User.get_all_users current_user
	end

	def save_shared_location
		flag = false
		if params[:latitude] != "" and params[:longitude] != ""
			location = Location.create!(:latitude=>params[:latitude], :longitude=>params[:longitude])
			if params[:is_public] and params[:is_public]=="true"
				shared_loc = SharedLocation.new
				shared_loc.user_id = current_user.id
				shared_loc.location_id = location.id
				shared_loc.is_public =  true
				flag = shared_loc.save ? true : false
			else
				user_ids = params[:users].split(",")
				user_ids.map{|u|
					share_location = SharedLocation.new
					share_location.location_id = location.id
					share_location.user_id = current_user.id
					share_location.target_user = u
					flag = share_location.save ? true : false
				}
			end
		else
			message = "Please select a location"
		end
		message = (flag==true) ? "Data saved succesfully" : "Something went wrong"

   		respond_to do |format|
          format.json {render :json => {"flag"=>flag,"message"=>message}}
      	end
	end
end
