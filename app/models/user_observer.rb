class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    @memberships = Membership.find_all_by_target_email(user.email)
    @memberships.each { |m| 
      if m.user_id.nil?
        m.user_id = user.id
        m.save!
      end
    }
  end
  
end
