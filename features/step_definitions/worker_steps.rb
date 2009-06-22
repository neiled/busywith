Given /^I own ([0-9]+) teams*$/ do |number|
  pending
end

# Then /^I should have a team called "([^\"]*)"$/ do |name|
#   UserSession.find.user.teams.first(:conditions => {:name => name}).nil? == false
# end

Then /^the user "([^\"]*)" should be an administrator of a team called "([^\"]*)"$/ do |login, name|
  user = User.find_by_login(login)
  user.owned_teams.select { |team| team.name == name }.should_not be_empty
end

Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  field_labeled(field).element.search(".//option[@selected = 'selected']").inner_html.should =~ /#{value}/
end