class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.integer :city_id
      t.integer :rating
      t.string :must_visit
      t.text :comment
      t.timestamps
    end
  end
end
