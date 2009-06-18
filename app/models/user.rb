class User < ActiveRecord::Base
  acts_as_authentic # for options see documentation: Authlogic::ORMAdapters::ActiveRecordAdapter::ActsAsAuthentic::Config
  has_many :teams, :foreign_key => "owner_id"
  belongs_to :active_project, :class_name => "Project", :foreign_key => "project_id"
  has_many :projects, :through => :teams
  has_many :memberships

end
