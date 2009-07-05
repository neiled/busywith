class MembershipObserver < ActiveRecord::Observer
  
  def after_update(membership)
    if membership.accepted_at_changed?
        History.create(:user_id => membership.user_id, :message => "joined the team '#{Team.find(membership.team_id).name}'", :message_type => "joined_team")
    end
  end
  
  def after_destroy(membership)
        History.create(:user_id => membership.user_id, :message => "left the team '#{Team.find(membership.team_id).name}'", :message_type => "left_team")    
  end
end
