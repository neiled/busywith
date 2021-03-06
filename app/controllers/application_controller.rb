class ApplicationController < ActionController::Base

  
  helper :all
  helper_method :current_user_session, :current_user
  
  protect_from_forgery

  filter_parameter_logging "password" unless Rails.env.development?

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def require_user
      require_signed_in_user
      require_active_user
    end
    
    def require_signed_in_user
      unless current_user
        store_location
        flash[:notice] = "You must be signed in to access this page"
        redirect_to signin_url
        return false
      end      
    end
    
    def require_active_user
      @user_session = UserSession.find
      if @user_session and @user_session.registration_complete? == false
        store_location
        flash[:notice] = "I'm sorry but we just need a few more details first!"
        redirect_to edit_user_url(current_user)
        return false        
      end      
    end

    def require_no_user
      if current_user and not current_user.is_admin
        store_location
        flash[:notice] = "You must be signed out to access this page"
        redirect_to :back
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end    


end
