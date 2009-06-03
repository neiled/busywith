class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Logged in"
      redirect_to(users_path)
    else
      render :action => "new"
    end
  end

  def destroy
    @user_session = UserSession.find
    if @user_session
      @user_session.destroy
      flash[:notice] = "Logged out."
      redirect_to(root_path)
    end
  end

end
