class Membership < ActiveRecord::Base
  include RFC822
  belongs_to :team
  belongs_to :user
  
  before_create :setup_admin, :match_target_email_with_user
  
  belongs_to :invitor, :class_name => "User", :foreign_key => "invitor_id"
  
  validates_format_of :target_email, :with => EmailAddress, :allow_blank => true
  
  private
  def setup_admin
    self.is_administrator ||= false
    return
  end
  
  def match_target_email_with_user
    found_user = User.find_by_email(self.target_email)
    if found_user
      self.user = found_user
    end
  end
  
  def validate
    test_invitor_is_owner
    test_invitiation_does_not_already_exist
  end
  
  def test_invitor_is_owner
    if self.invitor.nil? == false and self.team.users.count > 0 and self.invitor.owned_teams.find_by_id(self.team.id).nil?
      errors.add(:invitor_id, "You do not own that team")
    end
  end
  
  def test_invitiation_does_not_already_exist
    if Membership.find(:all, :conditions=>["team_id = ? and target_email = ?", self.team.id, self.target_email]).count > 0
      errors.add(:user_id, "That user already has an invite to your team!")
    end
    if Membership.find(:all, :conditions => ["team_id <> ? and target_email = ?", self.team.id, self.target_email]).count > 0
      errors.add(:user_id, "That user already has an invite to a different team!")      
    end
  end
end
