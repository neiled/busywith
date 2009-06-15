Given /^the following users$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    user = Factory.create(:user, :login => hash[:login])
    user.teams.create(:name => hash[:team]) unless hash[:team].nil?
  end
end

Then /^the user "([^\"]*)" should have an invite to the team "([^\"]*)"$/ do |login, team|
  User.find_by_login(login).memberships.find_by_team_id(Team.find_by_name(team)).should_not be_nil
end

When /^I change the hidden field "([^\"]*)" to "([^\"]*)"$/ do |field, value|
  set_hidden_field field, :to => value 
end
