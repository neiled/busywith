class UserMailer < ActionMailer::Base
  

  def signup(user)
    subject    'Welcome to busywith.com'
    recipients user.email
    from       'donotreply@busywith.com'
    sent_on    Time.now    
    body       :user => user
    
  end

  def team_invite(membership)
    user = User.find(membership.user_id)
    team = Team.find(membership.team_id)
    subject    'Team Invite - busywith.com'
    recipients user.email
    from       'donotreply@busywith.com'
    sent_on    Time.now    
    body       :user => user, :team => team, :membership => membership
  end
  
  def invite_new_user(membership)
    user = User.find(membership.user_id)
    team = Team.find(membership.team_id)
    subject    'Team Invite from busywith.com'
    recipients user.email
    from       'donotreply@busywith.com'
    sent_on    Time.now    
    body       :user => user, :team => team, :membership => membership    
  end

end
