class Team < ActiveRecord::Base
  has_many :users, :through => :memberships  
  has_many :projects
  has_many :memberships, :dependent => :destroy
  
  has_friendly_id :name, :use_slug => true
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
end
