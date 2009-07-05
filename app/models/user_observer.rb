class UserObserver < ActiveRecord::Observer
  
  def after_update(user)
    if user.current_task_changed?
      History.create(:user_id => user.id, :message => "updated their current task to '#{user.current_task}'", :message_type => "status_update")
    end
    if user.percent_complete_changed?
      History.create(:user_id => user.id, :message => "updated their percentage complete to #{user.percent_complete}%", :message_type => "status_update")
    end
    if user.project_id_changed?
      message = user.active_project ? "updated their active project to '#{user.active_project.name}'" : "cleared their active project"
      History.create(:user_id => user.id, :message => message, :message_type => "status_update")
    end
  end
  
end
