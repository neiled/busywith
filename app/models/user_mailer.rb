class UserMailer < ActionMailer::Base
  

  def signup(user)
    subject    'Welcome to busywith.com'
    recipients user.email
    from       'donotreply@busywith.com'
    sent_on    Time.now    
    body       :user => user
    
  end

  def beta(sent_at = Time.now)
    subject    'UserMailer#beta'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
