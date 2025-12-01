class AddBioFavSportUsernameToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :bio, :text
    add_column :users, :preferred_sports, :string, array: true, default: []
    add_column :users, :username, :string
    add_index :users, :username, unique: true
  end
end
