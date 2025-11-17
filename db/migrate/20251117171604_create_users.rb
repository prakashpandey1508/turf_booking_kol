class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password, null: false
      t.string :name, null: false
      t.string :role, null: false, default: 'user'
      t.timestamps
    end
  end
end
