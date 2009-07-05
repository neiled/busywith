class ChangeUserPercentCompleteToInt < ActiveRecord::Migration
  def self.up
    change_column :users, :percent_complete, :integer
    
  end

  def self.down
    change_column :users, :percent_complete, :float
  end
end
