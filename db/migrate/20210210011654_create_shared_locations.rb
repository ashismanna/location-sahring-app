class CreateSharedLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :shared_locations do |t|
    	t.references :user
    	t.references :location
    	t.boolean :is_public ,:default=>false
    	t.integer :target_user,:default=>nil
      t.timestamps
    end
  end
end
