class WelcomeController < ApplicationController

  def index
  end
  
  def email_signup
    email_address = params[:email]
    cm = CampaignMonitor.new(CAMPAIGN_MONITOR_API_KEY)
    cm.Subscriber.Add('ListID' => CAMPAIGN_MONITOR_LIST_ID, 'Email' => email_address, 'Name' => "")
    flash[:notice] = "Thanks! We'll be in touch!"
    redirect_to :action => "index"
  end

end
