require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :last_name => 'Dean',
      :first_name => 'James',
      :rank => 1
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes).should be_valid
  end
  
  it "is not valid without a first_name" do
    User.new(@valid_attributes.except(:first_name)).should_not be_valid
  end
  
  it "is not valid without a last_name" do
    User.new(@valid_attributes.except(:last_name)).should_not be_valid
  end
  
  it "is not valid without a rank" do
    User.new(@valid_attributes.except(:rank)).should_not be_valid
  end
  
  describe "as an instance" do
    before(:each) do
      @james = User.create!(@valid_attributes)
    end
    
    it "knows it's name" do
      @james.name.should eql('James Dean')
    end
  end
end
