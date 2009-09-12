class Team < ActiveRecord::Base
  has_many :users, :through => :memberships  
  has_many :projects
  has_many :memberships, :dependent => :destroy
end
