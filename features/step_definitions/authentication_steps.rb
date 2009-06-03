Then /^there should be ([0-9]+) users*$/ do |count|
  User.find(:all).count == count
end

Given /^I have a user with the username "([^\"]*)" and the password "([^\"]*)"$/ do |login, password|
  Factory.create(:user, :login => login, :password => password)
end

Given /^I am logged in as the user "([^\"]*)" with the password "([^\"]*)"$/ do |login, password|
  Factory.create(:user, :login => login, :password => password)
  visit login_url
  fill_in "login", :with => login
  fill_in "password", :with => password
  click_button "Login"
end

Then /^I should be logged out$/ do
  UserSession.find.nil?
end
