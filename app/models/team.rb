class Team < ActiveRecord::Base
  belongs_to :team_administrator, :class_name => "User", :foreign_key => "owner_id"
  has_many :projects
  has_many :memberships
end
