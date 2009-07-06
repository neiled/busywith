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
    
end
