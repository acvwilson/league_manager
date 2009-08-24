require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe League do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :sport => "value for sport",
      :start_date => Date.today,
      :end_date => 2.days.from_now.to_date
    }
  end

  it "should create a new instance given valid attributes" do
    League.create!(@valid_attributes)
  end
end
