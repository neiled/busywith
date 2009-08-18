module ApplicationHelper
  def page_title(title=nil)
    if title.nil?
      @page_title ||= ""
    else
      @page_title = title
    end
  end

  def body_class
    "#{controller.controller_name} #{controller.controller_name}_#{controller.action_name}"
  end
  
  def due_date(user)
    if user.estimated_completion.nil?
      ""
    else
      "#{user.estimated_completion.strftime("%m/%d/%Y")}"
    end
  end
  
  def team_tag(user)
    if(user.all_teams.count == 1)
      link_to "My Team", team_url(user.all_teams.first)
    else
      "Team: " + select_tag('Team', options_for_select((user.all_teams.map { |e| [e.name, team_url(e)] } << ["Choose a team...",""]).sort!, ""), :class => "choose_team")
    end
  end
    
end
