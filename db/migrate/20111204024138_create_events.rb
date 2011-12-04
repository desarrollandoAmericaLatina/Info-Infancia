class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :location_id
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
