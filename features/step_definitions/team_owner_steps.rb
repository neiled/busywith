Given /^I have a team called "([^\"]*)"$/ do |team_name|
  UserSession.find.user.teams.create!(:name => team_name)
end
