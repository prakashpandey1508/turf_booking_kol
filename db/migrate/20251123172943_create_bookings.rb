class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :turf, null: false, foreign_key: true
      t.datetime :booking_date
      t.datetime :start_time
      t.datetime :end_time
      t.integer :total_price
      t.integer :status, default: 0
      t.integer :total_hours
      t.string :payment_status, default: "unpaid"
      t.timestamps
    end
  end
end
