Factory.define :user do |f|
  f.username "neiled"
  f.password "password"
  f.password_confirmation {|u| u.password }
end