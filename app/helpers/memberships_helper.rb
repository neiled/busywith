module MembershipsHelper
  def membership_link(membership)
    if membership.user.login.nil?
      h(membership.user.email)
    else
      link_to h(membership.user.login || membership.user.email), profile_url(membership.user.login)
    end
  end
end
