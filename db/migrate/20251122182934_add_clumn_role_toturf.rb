class AddClumnRoleToturf < ActiveRecord::Migration[8.0]
  def up
    add_column :turves, :role, :string
  end

  def down
    remove_column :turves, :role
  end
end
