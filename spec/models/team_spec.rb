require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Team do
  before(:each) do
    @valid_attributes = {
      :name => "Equipo Grande"
    }
  end
  
  after(:all) do
    Team.destroy_all
  end

  it "should create a new instance given valid attributes" do
    Team.create!(@valid_attributes)
  end
  
  it "is not valid without a name" do
    @team = Team.new(@valid_attributes.except(:name))
    @team.should_not be_valid
  end
end
