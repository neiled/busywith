class UserStatusesController < ApplicationController
  
  before_filter :require_user
  
  def update
    @user = User.find(params[:user_id])
    @user_status = @user.user_status
    if @user_status.update_attributes(params[:user_status])
      flash[:notice] = "Status Updated"
    else
      flash[:error] = "I couldn't update your status: #{@user_status.errors.full_messages.first}"
    end    
    redirect_to :back    
  end
  
end
