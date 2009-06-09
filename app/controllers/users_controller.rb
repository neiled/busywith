class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account Registered"
      redirect_to(user_path(:login => @user.login))
    else
      render :action => "new"
    end
  end

  def destroy
  end
  
  def show
    @user = User.find_by_login(params[:login])
    unless @user
      flash[:notice] = "That user does not exist"
      redirect_to root_path
    end
  end

end
