Then /^there should be ([0-9]+) users*$/ do |count|
  User.find(:all).count == count
end