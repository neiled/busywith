class RemoveStatusUpdatesFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :current_task
    remove_column :users, :project_id
    remove_column :users, :percent_complete
    remove_column :users, :estimated_completion
    add_column :users, :user_status_id, :integer
  end

  def self.down
    remove_column :users, :users_status_id
    add_column :users, :estimated_completion, :datetime
    add_column :users, :percent_complete, :integer
    add_column :users, :project_id, :integer
    add_column :users, :current_task, :string

  end
end