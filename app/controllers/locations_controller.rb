class LocationsController < ApplicationController


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
