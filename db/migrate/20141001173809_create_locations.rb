class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :street, index: true
      t.string :zip, index: true
      t.string :city, index: true
      t.string :country, index: true
      t.string :sign
      t.timestamps
    end
  end
end
