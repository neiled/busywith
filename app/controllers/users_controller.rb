class UsersController < ApplicationController
  def new
    @user = User.new
    @user.email = params[:email] || ""
  end

  def create
    @user = User.new(params[:user])
    @user_status = @user.build_user_status    
    if @user.save and @user_status.save
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
    @user_status = @user.user_status
    unless @user
      flash[:notice] = "That user does not exist"
      redirect_to root_path
    end
  end
  
  # def update
  #   debugger
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(params[:user])
  #     flash[:notice] = "Status Updated"
  #   else
  #     flash[:error] = "Unable to update status: #{@user.errors.full_messages}"
  #   end    
  #   redirect_to :back
  # end

end
