require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  it "should succeed in creating a valid user" do
    Factory.create(:user)
  end
  it "should save username as lowercase" do
    user = Factory.create(:user, :login => 'Neil')
    user.login.should == "neil"  
  end
  
  it "should save email as lowercase" do
    user = Factory.create(:user, :email => 'Bob@PlasticWater.com')
    user.email.should == 'bob@plasticwater.com'
  end

end
