class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.string :pickup_location
      t.string :giveback_location
      t.string :activity
      t.integer :status
      t.datetime :pickup_time
      t.datetime :giveback_time
      t.references :user, null: false, foreign_key: true
      t.references :dog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
