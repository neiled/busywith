Given /^the following users$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    Given "I have a user with the username \"#{hash[:login]}\" and the password \"password\""
    unless hash[:team].nil?
      Given "I have a team called \"#{hash[:team]}\""
    end
    click_link "Sign out"
  end
end

Given /^the user "([^\"]*)" has an invite for the team "([^\"]*)"$/ do |login, team_name|
  user = User.find_by_login(login)
  team = Team.find_by_name(team_name)
  user.memberships.create(:team_id => team.id)
end


Given /^the user "([^\"]*)" is a member of the team "([^\"]*)"$/ do |login, team_name|
  User.find_by_login(login).memberships.create(:team_id => Team.find_by_name(team_name), :accepted_at => DateTime.now)
end

Given /^the user "([^\"]*)" has the status "([^\"]*)"$/ do |login, status|
  user = User.find_by_login(login)
  user.update_attribute(:current_task,status)
end




Then /^the user "([^\"]*)" should have an invite to the team "([^\"]*)"$/ do |login, team|
  User.find_by_login(login).invites.find_by_team_id(Team.find_by_name(team)).should_not be_nil
end

Then /^the user "([^\"]*)" should be a member of the team "([^\"]*)"$/ do |login, team_name|
  user = User.find_by_login(login)
  team = Team.find_by_name(team_name)
  user.memberships.find_by_team_id(team.id).accepted_at.should_not be_nil
end

Then /^the user "([^\"]*)" should not be a member of the team "([^\"]*)"$/ do |login, team_name|
  user = User.find_by_login(login)
  team = Team.find_by_name(team_name)
  if team
    user.memberships.find_by_team_id(team.id).should be_nil
  end
end

Then /^the user "([^\"]*)" should not have an invite to for the team "([^\"]*)"$/ do |login, team|
  User.find_by_login(login).memberships.find_by_team_id(Team.find_by_name(team)).should be_nil
end



When /^I change the hidden field "([^\"]*)" to "([^\"]*)"$/ do |field, value|
  set_hidden_field field, :to => value 
end
