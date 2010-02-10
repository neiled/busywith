class PasswordResetsController < ApplicationController
  
  def new

  end
  
  def create
    @user = User.find_by_email(params[:email])  
    if @user  
      @user.deliver_password_reset_instructions!  
      flash[:notice] = "We've emailed you some password reset instructions!"
      redirect_to signin_url  
    else  
      flash[:error] = "Are you sure that's your email address? We couldn't find it."  
      render :action => :new  
    end
  end

  
end
