class MembershipObserver < ActiveRecord::Observer
  
  def after_create(membership)
    unless membership.is_administrator
      user = User.find_by_id(membership.user_id)
      team = Team.find(membership.team_id)
      if(user.nil?)
        UserMailer.deliver_invite_new_user(membership)
      else
        UserMailer.deliver_team_invite(membership)
      end 
    end
  end
  
  def after_update(membership)
    if membership.accepted_at_changed?
        History.create(:user_id => membership.user_id, :message => "joined the team '#{Team.find(membership.team_id).name}'", :message_type => "joined_team")
    end
  end
  
  def after_destroy(membership)
    unless membership.accepted_at.nil?
      History.create(:user_id => membership.user_id, :message => "left the team '#{Team.find(membership.team_id).name}'", :message_type => "left_team")
    end
  end
end
