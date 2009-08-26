class UserStatusesController < ApplicationController
  
  def update
    @user = User.find(params[:user_id])
    @user_status = @user.user_status
    if @user_status.update_attributes(params[:user_status])
      flash[:notice] = "Status Updated"
    else
      flash[:error] = "Unable to update status: #{@user_status.errors.full_messages}"
    end    
    redirect_to :back    
  end
  
end
