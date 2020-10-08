class AddContactCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :contacts_count, :integer
  end
end
