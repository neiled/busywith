class UsersController < ApplicationController
  
  before_filter :require_signed_in_user, :only => [:edit, :update]
  before_filter :require_user, :except => [:new, :create, :edit, :update]
  
  def new
    @user = User.new
    @user.email = params[:email] || ""
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      setup_mail(@user)
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
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Details Updated"
      redirect_to(profile_path(current_user.login))
    else
      render :action => "edit"
    end    
    
  end
  
  private
  
  def setup_mail(user)
    UserMailer.deliver_signup(user)
    if Rails.env.production? || Rails.env.development?
      debugger
      list = CampaignMonitor::List.new(CM_SUBSCRIBERS_LIST_ID)
      list.add_subscriber_with_custom_fields(user.email, user.full_name, {:user_id => user.id})
      notify_prowl(user.email)
    end
  end
  
  def notify_prowl(email_address)
    Prowl.add(
      :apikey => PROWL_API_KEY,
      :application => "Busywith.com",
      :event => "Signed up",
      :description => email_address
    )
  end  
  
end
