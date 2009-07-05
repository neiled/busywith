class AddEstimatedCompletionToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :estimated_completion, :datetime
  end

  def self.down
    remove_column :users, :estimated_completion
  end
end
