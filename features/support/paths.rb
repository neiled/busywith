module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
      
    when /the registration page/
      new_user_path
    
    when /the user account page for "(.*)"/
      profile_path(:login => $1)
      
    when /the login page/
      signin_path
      
    when /the new team page/
      new_team_path
      
    when /the edit team page for "(.*)"/
      edit_team_path(Team.find_by_name($1))
      
    when /the team page for "(.*)"/
      team_path(Team.find_by_name($1))
      
    when /the forgotten password page/
      new_password_reset_path
      
    when /the password reset page for "(.*)"/
      edit_password_reset_path(User.find_by_login($1).perishable_token)
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
