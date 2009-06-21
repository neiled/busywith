class Team < ActiveRecord::Base
  belongs_to :team_administrator, :foreign_key => "owner_id", :class_name => "User"
  has_many :users, :through => :memberships  
  has_many :projects
  has_many :memberships
end
