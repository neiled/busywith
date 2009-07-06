class UserObserver < ActiveRecord::Observer
  
  def after_update(user)
    if user.current_task_changed?
      message = user.current_task.nil? ? "cleared their current task" : "updated their current task to '#{user.current_task}'"
      History.create(:user_id => user.id, :message => message, :message_type => "status_update")
    end
    if user.percent_complete_changed?
      History.create(:user_id => user.id, :message => "updated their percentage complete to #{user.percent_complete}%", :message_type => "status_update")
    end
    if user.estimated_completion_changed?
      message = user.estimated_completion.nil? ? "cleared their due date" : "updated their due date to #{user.estimated_completion.strftime("%m/%d/%Y")}"
      History.create(:user_id => user.id, :message => message, :message_type => "status_update")
    end    
    if user.project_id_changed?
      message = user.active_project ? "updated their active project to '#{user.active_project.name}'" : "cleared their active project"
      History.create(:user_id => user.id, :message => message, :message_type => "status_update")
    end
  end
  
end
