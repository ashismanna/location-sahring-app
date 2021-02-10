class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
		t.string :longitude
		t.string :latitude
		t.timestamps
    end
  end
end
