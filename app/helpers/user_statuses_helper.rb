module UserStatusesHelper
  def user_task_snippet(user)
    message = user.user_status.current_task_trimmed
    if(message.length > 45)
      message + "<img class=\"tooltip\" src=\"/images/more_message.png\" title=\"#{user.user_status.current_task}\"/>"
    else
      message
    end
  end
end
