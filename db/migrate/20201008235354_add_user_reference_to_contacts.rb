class AddUserReferenceToContacts < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :contacts, :users
    add_index :contacts, :user_id
    change_column_null :contacts, :user_id, false
  end
end
