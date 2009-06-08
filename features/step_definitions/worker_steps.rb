Given /^I own ([0-9]+) teams*$/ do |number|
  pending
end

Then /^I should have a team called "([^\"]*)"$/ do |name|
  User.first(:conditions => {:login => "neiled"}).teams.first(:conditions => {:name => "Neil's team"}).nil? == false
end
