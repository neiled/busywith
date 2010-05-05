ActionController::Routing::Routes.draw do |map|
  
  map.resources :teams, :has_many => :projects, :shallow => true 
  map.resources :users, :has_one => :user_status
  map.resources :user_sessions
  map.resources :memberships

  map.signin 'signin', :controller => 'user_sessions', :action => "new"
  map.signout 'signout', :controller => 'user_sessions', :action => "destroy"

  map.profile '/profile/:login', :controller => 'users', :action => 'show', :login => /.*/
                                              
  map.history '/history/:login', :controller => 'histories', :action => 'show', :login => /.*/, :format => "rss"

  map.beta_signup 'beta_signup', :controller => "welcome", :action => 'email_signup'
  
  map.thanks 'thanks', :controller => "welcome", :action => "thanks"
  map.contact_us 'contact-us', :controller => "welcome", :action => "contact_us"
  map.terms 'terms', :controller => "welcome", :action => "terms"
  map.help 'help', :controller => "welcome", :action => "help"
  map.privacy 'privacy', :controller => "welcome", :action => "privacy"
  
  map.admin 'admin', :controller => 'administration', :action => 'show'
  
  map.root :controller => "welcome"
  
  map.resources :password_resets
  
end
