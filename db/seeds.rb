# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

10.times{ |t,|
	user = User.create(:username=>"user_#{t}",:firstname=>"Sample",:lastname=>"User #{t}",:email=>"email#{t}@example.com",:password=>"tcs12345")
	# location = Location.create(:latitude=>81.99884943770512+(t*3), :longitude=>24.759262454384654+(t*4))
	# SharedLocation.create(:user_id=>user.id,:location_id=>location.id,)
}


