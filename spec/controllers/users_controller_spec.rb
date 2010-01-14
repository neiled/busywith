require 'spec_helper'

describe UsersController do
  
  before(:all) do
  end
  
  before(:each) do
    activate_authlogic
    @user = Factory.build(:user)    

  end
  
  describe "handling GET edit" do
    
    def do_get
      UserSession.create(@user)
      do_unauthenticated_get
    end
    
    def do_unauthenticated_get
      get :edit, :id => 6
    end
    
    it "should fail if we're not authenticated" do
      do_unauthenticated_get
      response.should_not be_success
    end
    it "should should find the current_user and assign it for the view" do
      do_get
      assigns[:user].should == @user
    end
    it "shold render the edit template" do
      do_get
      response.should render_template(:edit)
    end
  end
  
  describe "handling PUT update" do
    
    def do_put_with_valid_attributes
      UserSession.create(@user)      
      do_unauthenticated_put
    end
    
    def do_unauthenticated_put
      # @user.should_receive(:update_attributes).and_return(true)
      put :update, :id => 6, :user => {:email => "test@example.com"}      
    end
    
    it "should fail if we're not authenticated" do
      do_unauthenticated_put
      response.should_not be_success
    end
        
    it "should find the current_user and assign it for the view" do
      do_put_with_valid_attributes
      assigns[:user].should == @user
    end
  end
end