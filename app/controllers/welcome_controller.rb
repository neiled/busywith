class WelcomeController < ApplicationController

  layout "welcome"
  
  def index
  end
  
  def email_signup
    email_address = params[:email]
    unless email_address.empty?
      cm = CampaignMonitor.new(CAMPAIGN_MONITOR_API_KEY)
      cm.Subscriber.Add('ListID' => CAMPAIGN_MONITOR_LIST_ID, 'Email' => email_address, 'Name' => "")
      redirect_to :action => "thanks"
    else
      flash[:error] = "Are you sure that's your email address? It seems blank!"
      redirect_to :action => "index", :anchor => "email"
    end
  end
  
  def thanks
  end

end
