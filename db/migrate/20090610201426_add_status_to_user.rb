class AddStatusToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :current_task, :string
    add_column :users, :project_id, :integer
    add_column :users, :percent_complete, :float
  end

  def self.down
    remove_column :users, :percent_complete
    remove_column :users, :project_id
    remove_column :users, :current_task
  end
end
