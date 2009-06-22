Factory.define :user do |f|
  f.login "neiled"
  f.password "password"
  f.password_confirmation {|u| u.password }
end

Factory.define :team do |f|
  f.name "a team"
end