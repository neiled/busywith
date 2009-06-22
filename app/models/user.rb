class User < ActiveRecord::Base
  acts_as_authentic # for options see documentation: Authlogic::ORMAdapters::ActiveRecordAdapter::ActsAsAuthentic::Config
  #has_many :owned_teams, :foreign_key => "owner_id", :class_name => "Team"
  belongs_to :active_project, :class_name => "Project", :foreign_key => "project_id"
  has_many :projects, :through => :teams
  has_many :memberships
  has_many :teams, :through => :memberships, :foreign_key => "owner_id"
  has_many :owned_teams, :through => :memberships, :source => "team", :class_name => "Team",
    :conditions => { :memberships => {:is_administrator => true} }
end
