class RemoveNullValueFromPassword < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :password, true
    change_column_null :users, :name, true
  end
end
