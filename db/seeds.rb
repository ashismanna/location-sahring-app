# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#

10.times{ |t|
	user = User.create(:username=>"user_#{t}",:firstname=>"Sample",:lastname=>"User #{t}",:email=>"email#{t}@example.com",:password=>"tcs12345")
	location = Location.create(:latitude=>81.99884943770512+(t*2), :longitude=>24.759262454384654+(t*3))
	# SharedLocation.create(:user_id=>user.id,:location_id=>location.id,)

}
user_ids = User.all.collect(&:id)
location_ids = Location.all.collect(&:id)
9.times{|t|
	(t/2==0) ? SharedLocation.create(:user_id=>user_ids[t],:location_id=>location_ids.sample,:is_public=>1,:target_user=>user_ids.sample) : SharedLocation.create(:user_id=>user_ids[t],:location_id=>location_ids.sample,:is_public=>0,:target_user=>user_ids.sample)
}


