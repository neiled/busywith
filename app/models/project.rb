class Project < ActiveRecord::Base
  belongs_to :team
  has_many :users
  
  validates_length_of :name, :within => 3..20, :on => :create, :message => "must be present"
  validates_uniqueness_of :name, :on => :create, :message => "already exists"
end
