class User < ActiveRecord::Base
  acts_as_authentic # for options see documentation: Authlogic::ORMAdapters::ActiveRecordAdapter::ActsAsAuthentic::Config
  #has_many :owned_teams, :foreign_key => "owner_id", :class_name => "Team"
  belongs_to :active_project, :class_name => "Project", :foreign_key => "project_id"
  has_many :projects, :finder_sql => 'SELECT projects.*
                                      FROM projects
                                      JOIN teams ON teams.id = projects.team_id
                                      JOIN memberships ON memberships.team_id = teams.id
                                      JOIN users ON users.id = memberships.user_id
                                      WHERE users.id = #{id}'

  has_many :memberships, :conditions => "accepted_at IS NOT NULL"
  
  has_many :invites, :class_name => "Membership", :conditions => {:accepted_at => nil}

  has_many :all_teams, :through => :memberships, :source => "team", :class_name => "Team"

  has_many :teams, :through => :memberships, :foreign_key => "owner_id",
    :conditions => { :memberships => {:is_administrator => false} }

  has_many :owned_teams, :through => :memberships, :source => "team", :class_name => "Team",
    :conditions => { :memberships => {:is_administrator => true} }
end
