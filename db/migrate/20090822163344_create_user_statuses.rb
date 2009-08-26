class CreateUserStatuses < ActiveRecord::Migration
  def self.up
    create_table :user_statuses do |t|
      t.string :current_task
      t.integer :project_id
      t.integer :percent_complete
      t.datetime :estimated_completion

      t.timestamps
    end
  end

  def self.down
    drop_table :user_statuses
  end
end
