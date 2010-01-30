class WelcomeController < ApplicationController

  layout "welcome"
  
  def index
  end
  
  def email_signup
    email_address = params[:email]
    unless email_address.empty?
      add_email(email_address)
      notify_prowl(email_address)
      redirect_to :action => "thanks"
    else
      flash[:error] = "Are you sure that's your email address? It seems blank!"
      redirect_to :action => "index", :anchor => "email"
    end
  end
  
  def thanks
  end
  
  def contact_us
    
  end
  
  private
  
  def add_email(email_address)
    cm = CampaignMonitor.new(CAMPAIGN_MONITOR_API_KEY)
    cm.Subscriber.Add('ListID' => CAMPAIGN_MONITOR_LIST_ID, 'Email' => email_address, 'Name' => "")    
  end
  
  def notify_prowl(email_address)
    Prowl.add(
      :apikey => PROWL_API_KEY,
      :application => "Busywith.com",
      :event => "Subscribed",
      :description => email_address
    )
    
  end

end
