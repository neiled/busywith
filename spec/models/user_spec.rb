require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

it "should save username as lowercase" do
  user = Factory(:user, :login => 'Bob')
  user.login.should == "bob"  
end

it "should save email as lowercase" do
  user = Factory(:user, :email => 'Bob@PlasticWater.com')
  user.email.should == 'bob@plasticwater.com'
end

end
