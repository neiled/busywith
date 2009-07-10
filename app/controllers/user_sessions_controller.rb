class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "You are now signed in"
      redirect_back_or_default(profile_path(:login => @user_session.user.login))
    else
      render :action => "new"
    end
  end

  def destroy
    @user_session = UserSession.find
    if @user_session
      @user_session.destroy
      flash[:notice] = "Signed out"
      redirect_to(root_path)
    end
  end

end
