class AddDisplayNameAndRemoveFirstAndLastNameFromUser < ActiveRecord::Migration
  def self.up
    add_column :users, :display_name, :string
    remove_column :users, :first_name
    remove_column :users, :last_name
  end

  def self.down
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    remove_column :users, :display_name
  end
end
