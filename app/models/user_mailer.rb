class UserMailer < ActionMailer::Base
  

  def signup(user)
    subject    'Welcome to busywith.com'
    recipients user.email
    from       'donotreply@busywith.com'
    sent_on    Time.now    
    body       :user => user
    content_type "text/html"
  end

  def team_invite(membership)
    user = User.find(membership.user_id)
    team = Team.find(membership.team_id)
    subject    'Team Invite - busywith.com'
    recipients user.email
    from       'donotreply@busywith.com'
    sent_on    Time.now    
    body       :user => user, :team => team, :membership => membership
    content_type "text/html"
  end
  
  def invite_new_user(membership)
    subject    'Team Invite from busywith.com'
    recipients  membership.target_email
    from       'donotreply@busywith.com'
    sent_on    Time.now
    body       :membership => membership
    content_type "text/html"
  end
  
  def password_reset_instructions(user)
    subject     "Busywith.com - Reset your password"
    recipients  user.email
    from        "donotreply@busywith.com"
    sent_on     Time.now
    body        :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
    content_type "text/html"
  end

end
