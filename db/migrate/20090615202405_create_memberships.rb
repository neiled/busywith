class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :team_id
      t.integer :user_id
      t.datetime :accepted_at
      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
