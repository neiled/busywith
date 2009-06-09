Given /^I have a team called "([^\"]*)"$/ do |team_name|
  UserSession.find.user.teams.create!(:name => team_name)
end

Given /^I have a project called "([^\"]*)"$/ do |project|
  UserSession.find.user.teams.find(:first).projects.create!(:name => project)
end
