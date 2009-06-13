Given /^I own ([0-9]+) teams*$/ do |number|
  pending
end

Then /^I should have a team called "([^\"]*)"$/ do |name|
  UserSession.find.user.teams.first(:conditions => {:name => name}).nil? == false
end

Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  field_labeled(field).element.search(".//option[@selected = 'selected']").inner_html.should =~ /#{value}/
end