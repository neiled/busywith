class SwapForeignKeysForUserStatus < ActiveRecord::Migration
  def self.up
    add_column :user_statuses, :user_id, :integer
    remove_column :users, :user_status_id
  end

  def self.down
    add_column :users, :user_status_id, :integer
    remove_column :user_statuses, :user_id
  end
end
