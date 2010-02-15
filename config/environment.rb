# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION
CAMPAIGN_MONITOR_API_KEY = '952c70caa35c8577c494995978b72b7a'
RPX_API_KEY = "9c8858925c198fee73e8ef0cd492b6f91cc5ed0c"
PROWL_API_KEY = "1e6a51e64611e845b3fa9c2e54b9871cfc93b4f3"

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'authlogic'
  config.gem 'chriseppstein-compass', :lib => 'compass', :source => 'http://gems.github.com'
  config.gem 'haml', :lib => 'haml'
  config.gem 'validates_timeliness'
  config.gem 'rubaidh-google_analytics', :lib => 'rubaidh/google_analytics', :source => 'http://gems.github.com'
  config.gem 'seven1m-campaign_monitor', :lib => 'campaign_monitor'
  config.gem "grosser-rpx_now", :lib => "rpx_now", :source => "http://gems.github.com/"  
  config.gem "tardate-authlogic_rpx", :lib => "authlogic_rpx", :source => 'http://gems.github.com'  
  config.gem "friendly_id"
  config.gem "hoptoad_notifier"
  config.gem "prowl"
  # config.gem 'patientslikeme-campaign_monitor', :lib => 'campaign_monitor', :source => 'http://gems.github.com'  
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.active_record.observers = :user_status_observer, :membership_observer, :user_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
  
  config.action_mailer.delivery_method = :smtp

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  config.action_mailer.raise_delivery_errors = true  
  config.action_mailer.default_url_options = { :host =>
  "busywith.com" }
end

Rubaidh::GoogleAnalytics.tracker_id = 'UA-1098906-6'
RPXNow.api_key = RPX_API_KEY

# ActionMailer::Base.smtp_settings = {
#   :address => "smtp.gmail.com",
#   :port => 587,
#   :authentication => :plain,
#   :enable_starttls_auto => true,
#   :user_name => "donotreply@busywith.com",
#   :password => "L84587"
# }
