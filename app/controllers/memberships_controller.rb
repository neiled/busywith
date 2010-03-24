class MembershipsController < ApplicationController
  
  before_filter :require_user
  
  def create
    @team = current_user.owned_teams.find_by_id(params[:team_id])
    if @team.nil?
      flash[:error] = "You do not own that team."
      redirect_to :back
      return
    end
    
    @user = User.find_by_email(params[:email].downcase)
    
    if @team.users.include?(@user)
      flash[:notice] = "That user already has an invite to your team!"
      redirect_to(@team)
      return
    elsif @user.invites.count > 0
      flash[:notice] = "That user already has an invite to a different team!"
      redirect_to(@team)
      return
    elsif @user.memberships.count > 0
      flash[:notice] = "That user is already a member of a different team!"
      redirect_to(@team)
      return
    end
    
    if @user.nil?
      @user = User.new(:email => params[:email])
      @user.valid? #this is so the errors.on array is filled
    end
    
    #was there a problem with the email address?
    if @user.errors.on(:email).nil?
      #does this user exist already?
      if @user.login.nil?
        #no, so create a membership for that email address
        @membership = Membership.new(:team_id => @team.id, :invitor_id => current_user.id, :target_email => params[:email])
      else
        #yes, so point the invite directly at the user
        @membership = @user.memberships.build(:team_id => @team.id, :invitor_id => current_user.id)
      end
      
      if @membership.save
        flash[:notice] = "We've sent them an email inviting them!"
      else
        flash[:error] = @membership.errors.full_messages.to_s
      end
    else
      flash[:error] = "That email address doesn't look right, it:<br/>" + @user.errors.on(:email).join("<br/>")
    end
    
    respond_to do |wants|
      wants.html { redirect_to @team }
      wants.js { }
    end
  end

  def update
    @membership = current_user.invites.find_by_id(params[:id])
    unless @membership.nil?
      @membership.update_attribute(:accepted_at, DateTime.now)
      flash[:notice] = "Invite Accepted"
    else
      flash[:error] = "That invite does not exist"
    end
    redirect_to :back        
  end
  
  def destroy
    #see if the membership id is a membership that the current user has
    @membership = current_user.memberships.find_by_id(params[:id])
    #if it's not, see if it's an invite they have
    @membership ||= current_user.invites.find_by_id(params[:id])
    # If we still didn't find a membership, then look to see if the membership_id relates a membership of a team that the current user owns
    # this way the current user can remove someone from their team
    if @membership.nil?
      #does the membership exist at all?
      found_membership = Membership.find(params[:id])
      unless found_membership.nil?
        #if it does, see if the current user owns a team with that the membership points to
        @membership ||= current_user.owned_teams.find_by_id(found_membership.team_id).nil? ? nil : found_membership
      end
    end
    unless @membership.nil?
      if @membership.accepted_at.nil?
        if current_user.owned_teams.find_by_id(@membership.team)
          flash[:notice] = "You've withdrawn your invite."
        else
          flash[:notice] = "Invite Ignored."
        end
      else
        if current_user.owned_teams.find_by_id(@membership.team)
          flash[:notice] = "#{@membership.user.login.capitalize} has been removed from the team"
        else
          flash[:notice] = "You are no longer a member of the team #{@membership.team.name}"
        end
      end
      @membership.destroy      
    else
      flash[:error] = "That invite does not exist"
    end
    redirect_to :back
  end

end
