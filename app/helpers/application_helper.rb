module ApplicationHelper
  def page_title(title=nil)
    if title.nil?
      @page_title ||= ""
    else
      @page_title = title
    end
  end

  def body_class
    "#{controller.controller_name}_#{controller.action_name}"
  end
  
  def due_date(user)
    if user.user_status.nil? or user.user_status.estimated_completion.nil?
      ""
    else
      "#{user.user_status.estimated_completion.strftime("%m/%d/%Y")}"
    end
  end
  
  def team_tag(user)
    if(user.all_teams.count == 0)
      nil #link_to "My Team", profile_url(user.login)
    else
      link_to "My Team", team_url(user.all_teams.first)
    end
  end
      
end
