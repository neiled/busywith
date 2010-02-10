ActionController::Routing::Routes.draw do |map|
  
  map.resources :teams, :has_many => :projects, :shallow => true 
  map.resources :users, :has_one => :user_status, :except => ["index"]
  map.resources :user_sessions
  map.resources :memberships

  map.signin 'signin', :controller => 'user_sessions', :action => "new"
  map.signout 'signout', :controller => 'user_sessions', :action => "destroy"

  map.profile '/profile/:login', :controller => 'users', :action => 'show', :login => /.*/
                                              
  map.history '/history/:login', :controller => 'histories', :action => 'show', :login => /.*/, :format => "rss"

  map.beta_signup 'beta_signup', :controller => "welcome", :action => 'email_signup'
  
  map.thanks 'thanks', :controller => "welcome", :action => "thanks"
  map.contact_us 'contact-us', :controller => "welcome", :action => "contact_us"
  
  map.root :controller => "welcome"
  
  map.resources :password_resets
  
end
