class Membership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  
  before_create :setup_admin
  
  belongs_to :invitor, :class_name => "User", :foreign_key => "invitor_id"
  
  def setup_admin
    self.is_administrator ||= false
    return
  end
end
