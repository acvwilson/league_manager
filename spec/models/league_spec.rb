require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe League do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :season => "value for season",
      :sport => "value for sport"
    }
  end

  it "should create a new instance given valid attributes" do
    League.create!(@valid_attributes)
  end
end
