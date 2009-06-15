class Membership < ActiveRecord::Base
  has_one :team, :class_name => "Team", :foreign_key => "team_id"
  has_one :user, :class_name => "User", :foreign_key => "user_id"
end
