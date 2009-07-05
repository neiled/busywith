class Membership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  
  before_create :setup_admin
  
  def setup_admin
    self.is_administrator ||= false
    return
  end
end
