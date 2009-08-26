require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserStatus do
  before(:each) do
    @valid_attributes = {
      :current_task => "value for current_task",
      :project_id => 1,
      :percent_complete => 1,
      :estimated_completion => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    UserStatus.create!(@valid_attributes)
  end
end
