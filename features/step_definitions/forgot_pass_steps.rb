Given /^the user "([^\"]*)" has forgotten their password$/ do |email|
  Given "I am on the forgotten password page"
  Then "I fill in \"email\" with \"#{email}\""
  Then "I press \"Submit\""
end
