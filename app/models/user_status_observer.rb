class UserStatusObserver < ActiveRecord::Observer
  
  def after_update(user_status)
    return if user_status.nil?
    
    if user_status.current_task_changed?
      message = user_status.current_task.nil? ? "cleared their current task" : "updated their current task to '#{user_status.current_task}'"
      History.create(:user_id => user_status.user.id, :message => message, :message_type => "status_update")
    end
    if user_status.percent_complete_changed?
      History.create(:user_id => user_status.user.id, :message => "updated their percentage complete to #{user_status.percent_complete}%", :message_type => "status_update")
    end
    if user_status.estimated_completion_changed?
      message = user_status.estimated_completion.nil? ? "cleared their due date" : "updated their due date to #{user_status.estimated_completion.strftime(DATE_TIME_FORMAT)}"
      History.create(:user_id => user_status.user.id, :message => message, :message_type => "status_update")
    end    
    if user_status.project_id_changed?
      message = user_status.active_project ? "updated their active project to '#{user_status.active_project.name}'" : "cleared their active project"
      History.create(:user_id => user_status.user.id, :message => message, :message_type => "status_update")
    end
  end
  
end
