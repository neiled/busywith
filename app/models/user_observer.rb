class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    check_memberships(user) unless user.email.nil?
  end
  
  def after_update(user)
    check_memberships(user) unless not user.email_changed?
  end
  
  private
  
  def check_memberships(user)
    # go through all the memberships that point to this new user
    # and assign the correct user_id to them, they start off with a null
    # user_id because of course we don't know what the user_id is going to be!
    @memberships = Membership.find_all_by_target_email(user.email)
    @memberships.each { |m| 
      if m.user_id.nil?
        m.target_email = nil
        m.user_id = user.id
        m.save!
      end
    }      
  end
  
end
