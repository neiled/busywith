class AddTargetEmailToMembership < ActiveRecord::Migration
  def self.up
    add_column :memberships, :target_email, :string
  end

  def self.down
    remove_column :memberships, :target_email
  end
end
