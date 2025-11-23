class AddPhoneNumberToUsers < ActiveRecord::Migration[8.0]
  def up
    add_column :users, :phone_number, :string
  end

  def down
    remove_column :users, :phone_number, :string
  end
end
