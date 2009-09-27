class UsersController < ApplicationController
  
  before_filter :require_user, :except => [:new, :create]
  
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
      flash[:notice] = "The user #{params[:login]}does not exist"
      redirect_to profile_path(:login => current_user.login)
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Details Updated"
      redirect_to(profile_path(current_user.login))
    else
      render :action => "edit"
    end    
    
  end
  
end
