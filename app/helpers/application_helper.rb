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
      "#{user.user_status.estimated_completion.strftime(DATE_TIME_FORMAT)}"
    end
  end
  
  def team_tag(user)
    if(user.owned_teams.count == 0)
      nil #link_to "My Team", profile_url(user.login)
    else
      link_to "My Team", edit_team_url(user.all_teams.first)
    end
  end
  
  def overview_tag(user)
    if(user.all_teams.count == 0)
      nil #link_to "My Team", profile_url(user.login)
    else
      link_to "Overview", team_url(user.all_teams.first)
    end
  end  
  
  def require_stylesheet(name)
    stylesheet_link_tag "compiled/#{name}.css"
  end
    
end
