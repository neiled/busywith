class AdministrationController < ApplicationController
  
  before_filter :is_admin?
  
  def show
    @users = User.all
  end
  
  private
  
  def is_admin?
    unless current_user && current_user.is_admin
      flash[:error] = "Sorry, this area is for administrators only."
      redirect_to(root_url)
    end
  end
  
end
