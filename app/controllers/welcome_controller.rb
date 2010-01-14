class WelcomeController < ApplicationController

  def index
  end
  
  def email_signup
    email_address = params[:email]
    # cm = CampaignMonitor.new(CAMPAIGN_MONITOR_API_KEY)
    # cm.Subscriber.Add('ListID' => CAMPAIGN_MONITOR_LIST_ID, 'Email' => email_address, 'Name' => "")
    redirect_to :action => "thanks"
  end
  
  def thanks
  end

end
