Then /^the user "([^\"]*)" should have the full name "([^\"]*)"$/ do |login, new_name|
  User.find_by_login(login).display_name.should == new_name
end

Then /^the user "([^\"]*)" should have the email adddress "([^\"]*)"$/ do |login, email|
  User.find_by_login(login).email.should == email
end

Then /^the user "([^\"]*)" should have the password "([^\"]*)"$/ do |login, password|
  user = User.find_by_login(login)
  salt = user.password_salt
  user.crypted_password.should == Authlogic::CryptoProviders::Sha512.encrypt(password + salt)
end
