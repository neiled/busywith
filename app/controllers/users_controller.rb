class UsersController < ApplicationController
  
  before_filter :require_user, :only => [:show]
    
  def new
    @user = User.new
    @user.email = params[:email] || ""
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.deliver_signup(@user)
      flash[:notice] = "Account Registered"
      redirect_to(profile_path(:login => @user.login))
    else
      render :action => "new"
    end
  end

  def destroy
  end
  
  def show
    @user = User.find_by_login(params[:login])
    if @user
      @user_status = @user.user_status    
    else
      flash[:notice] = "That user does not exist"
      redirect_to profile_path(:login => current_user.login)
    end
  end
  
end
