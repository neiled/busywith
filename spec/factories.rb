Factory.sequence :login do |n|
  "login100#{n}"
end


Factory.define :user do |f|
  f.login {Factory.next(:login)}
  f.password "password"
  f.email {|a| "#{a.login}@blah.com".downcase }  
  f.display_name "Neil Edwards"
  f.password_confirmation {|u| u.password }
end

Factory.define :team do |f|
  f.name "a team"
end
