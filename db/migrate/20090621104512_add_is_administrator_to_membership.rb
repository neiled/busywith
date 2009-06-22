class AddIsAdministratorToMembership < ActiveRecord::Migration
  def self.up
    add_column :memberships, :is_administrator, :boolean
  end

  def self.down
    remove_column :memberships, :is_administrator
  end
end
