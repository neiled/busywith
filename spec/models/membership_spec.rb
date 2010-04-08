require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Membership do
  
  before(:each) do
    @owner = Factory.create(:user)
    @team = Factory.create(:team)
    Membership.create(:user=>@owner, :team=>@team, :is_administrator=>true, :accepted_at => DateTime.now)
  end
  
  it "should be valid with a blank email" do
    membership = Membership.new(:invitor=>@owner, :team=>@team,:target_email=>"")
    membership.should be_valid
  end
  
  it "should not be valid with an invalid email" do
    membership = Membership.new(:invitor=>@owner, :team=>@team,:target_email=>"blah")
    membership.should_not be_valid
  end
  
  it "should be valid with a valid email address" do
    membership = Membership.new(:invitor=>@owner,:team=>@team,:target_email=>"neil@plasticwater.com")
    membership.should be_valid
  end
  
  it "should be invalid if the owner doesn't own the team" do
    not_owner = Factory.create(:user)
    membership = Membership.new(:invitor => not_owner, :target_email=>"test@example.com", :team => @team)
    membership.should_not be_valid
  end
  
  it "should be valid if the owner does own the team" do
    membership = Membership.new(:invitor => @owner, :target_email => "test@example.com", :team => @team)
    membership.should be_valid
  end
  
  it "should be invalid if the target user already has an invite to the team" do
    first_membership = Membership.create(:invitor => @owner, :target_email => "test@example.com", :team=>@team)
    second_membership = Membership.new(:invitor => @owner, :target_email => "test@example.com", :team=>@team)
    second_membership.should_not be_valid
  end
  
  it "should be invalid if the target user already has an invite to another team" do
    other_team = Factory.create(:team)
    first_membership = Membership.create(:invitor => @owner, :target_email => "test@example.com", :team=>other_team)
    second_membership = Membership.new(:invitor => @owner, :target_email => "test@example.com", :team=>@team)
    second_membership.should_not be_valid    
  end
  
  it "should point at the user if that user already exists" do
    user = Factory.create(:user, :email => "thisuserexists@example.com")
    membership = Membership.create(:invitor => @owner, :target_email=>"thisuserexists@example.com", :team => @team)
    membership.user.should == user
  end
  
  it "should not let a user invite themselves" do
    membership = Membership.new(:invitor => @owner, :target_email=>@owner.email, :team => @team)
    membership.should_not be_valid
  end
  
end