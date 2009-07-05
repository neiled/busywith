class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.integer :user_id
      t.integer :subject_id
      t.string :message
      t.string :message_type
      t.timestamps
    end
  end

  def self.down
    drop_table :histories
  end
end
