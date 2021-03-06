Then /^there should be ([0-9]+) users*$/ do |count|
  User.find(:all).size == count
end

Given /^I am logged in as the user "([^\"]*)"$/ do |login|
  visit signin_url
  fill_in "login", :with => login
  fill_in "password", :with => "password"
  click_button "Sign in"
end

Then /^I should be logged out$/ do
  UserSession.find.nil?
end

Given /^I have a user with the username "([^\"]*)" and the password "([^\"]*)"$/ do |login, password|
  visit new_user_url
  fill_in "login", :with => login
  fill_in "email", :with => login + "@plasticwater.com"
  fill_in "display name", :with => login
  fill_in "password", :with => password
  fill_in "password confirmation", :with => password
  click_button "Sign up"
end
