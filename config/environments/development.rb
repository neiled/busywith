# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false
config.action_mailer.delivery_method = :test
#config.gem 'quietbacktrace'

CAMPAIGN_MONITOR_LIST_ID = '59b7a6cb00a8ff1b20ce1b9c640f75d2'
CM_SUBSCRIBERS_LIST_ID = 'bb0f3470c383276b306ac02366a5b2cc'

ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true,
  :user_name => "donotreply@busywith.com",
  :password => "L84587"
}

