class AddInvtorToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :invitor_id, :integer
  end

  def self.down
    remove_column :memberships, :invitor_id
  end
end
