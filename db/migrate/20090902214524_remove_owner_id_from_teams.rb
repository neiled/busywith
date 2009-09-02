class RemoveOwnerIdFromTeams < ActiveRecord::Migration
  def self.up
    remove_column :teams, :owner_id
  end

  def self.down
    add_column :teams, :owner_id, :integer
  end
end
