class PasswordResetsController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user  
  
  def new

  end
  
  def create
    @user = User.find_by_email(params[:email])  
    if @user  
      @user.deliver_password_reset_instructions!  
      flash[:notice] = "We've emailed you some password reset instructions!"
      redirect_to signin_url  
    else  
      flash[:error] = "Are you sure that's your email address? We couldn't find it :("  
      render :action => :new  
    end
  end
  
  def edit
    
  end
  
  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "We've updated your password and logged you in!"
      redirect_to profile_path(@user.login)
    else
      render :action => :edit
    end
  end  

  private
  
    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:id])
      unless @user
        flash[:error] = "We're sorry, but we could not locate your account. " +
          "If you are having issues try copying and pasting the URL " +
          "from your email into your browser or restarting the " +
          "reset password process."
        redirect_to signin_url
      end
    end
  
end
