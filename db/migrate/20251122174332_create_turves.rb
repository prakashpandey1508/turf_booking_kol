class CreateTurves < ActiveRecord::Migration[8.0]
  def change
    create_table :turves do |t|
      t.string :name
      t.string :pin_code
      t.string :address
      t.integer :price_per_hour
      t.boolean :availability, default: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
