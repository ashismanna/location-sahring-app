class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shared_locations
  validates :email, :uniqueness => true
  validates :username, :uniqueness => true

  def self.get_all_users(user)
  	(user and user.present?) ? self.where("id not in (?)",user.id) : []
  end

	def get_public_locations(all=nil)
		shared_locations = (all==true) ? self.shared_locations : self.shared_locations.where(:is_public=>true) #if self.shared_locations
    (shared_locations and shared_locations.present?) ? Location.where(:id => shared_locations.collect(&:location_id)) : []
	end

  def get_location_shared_with_current_user
    shared_locations = SharedLocation.where(:target_user=>self.id)
    (shared_locations and shared_locations.present?) ? Location.where(:id => shared_locations.collect(&:location_id)) : []
  end

  def fullname
    fname = ""
    fname += self.firstname.capitalize if self.firstname
    fname += " "+self.lastname.capitalize if self.lastname
    fname
  end

  def self.find_for_database_authentication(conditions={})
  find_by(username: conditions[:email]) || find_by(email: conditions[:email])
end


end
