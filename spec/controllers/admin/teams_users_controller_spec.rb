require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::TeamsUsersController do
  describe "POST 'create'" do
    before(:each) do
      @user = mock_model(User, :teams => [@team], :save => true)
      @team = mock_model(Team)
      User.stub!(:find).and_return(@user)
      Team.stub!(:find).and_return(@team)
    end
    
    def doittoit
      post :create, :team_id => 1, :user_id => 2
    end
    
    it "should redirect to team edit" do
      doittoit
      response.should redirect_to(admin_team_path(@team))
    end
    
    it "looks up the user" do
      User.should_receive(:find).with('2').and_return(@user)
      doittoit
    end
    
    it "looks up the team" do
      Team.should_receive(:find).with('1').and_return(@team)
      doittoit
    end
    
    it "adds the team to the user" do
      @user.should_receive(:teams).and_return([@team])
      @user.should_receive(:save).and_return(true)
      doittoit
    end
  end
end
