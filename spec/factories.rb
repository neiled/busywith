Factory.define :user do |f|
  f.login "neiled"
  f.password "password"
  f.email "neil@plasticwater.com"
  f.first_name "Neil"
  f.last_name "Edwards"
  f.password_confirmation {|u| u.password }
end

Factory.define :team do |f|
  f.name "a team"
end