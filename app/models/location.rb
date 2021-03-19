class Location < ApplicationRecord
	has_many :shared_locations
	 validates :longitude, :presence => true
	 validates :longitude, :presence => true
end
