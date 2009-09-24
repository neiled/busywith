Factory.define :user do |f|
  f.login "neiled"
  f.password "password"
  f.email "neil@plasticwater.com"
  f.display_name "Neil Edwards"
  f.password_confirmation {|u| u.password }
end

Factory.define :team do |f|
  f.name "a team"
end