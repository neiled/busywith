class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      if @user_session.new_registration?
              flash[:notice] = "Welcome! As a new user, please review your registration details before continuing.."
              redirect_to edit_user_path( current_user )
      else
              if @user_session.registration_complete?
                      flash[:notice] = "You are now signed in"
                      redirect_back_or_default profile_path(current_user.login)
              else
                      flash[:notice] = "Welcome back! Please complete required registration details before continuing.."
                      redirect_to edit_user_path( current_user )
              end
      end      
    else
      flash[:error] = "I was unable to log you in or to register you."
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
  
  def index
    redirect_to current_user ? root_url : new_user_session_url
  end

end
