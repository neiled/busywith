Given /^I have a team called "([^\"]*)"$/ do |team_name|
  visit(new_team_url)
  fill_in("Team Name", :with => team_name)
  click_button("Create Team")
end

Given /^I have a team called "([^\"]*)" with a project called "([^\"]*)"$/ do |team_name, project|
  # UserSession.find.user.teams.create!(:name => team_name)
  # UserSession.find.user.teams.find_by_name(team_name).projects.create!(:name => project)
  visit(new_team_url)
  fill_in("Team Name", :with => team_name)
  click_button("Create Team")
  visit(edit_team_url Team.find_by_name(team_name))
  click_link("Add Project")
  fill_in("Project Name", :with => project)
  click_button("Add Project")
end
