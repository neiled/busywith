class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account Registered"
      redirect_to(users_url)
    else
      render :action => "new"
    end
  end

  def destroy
  end
  
  def show
    
    
  end

end
