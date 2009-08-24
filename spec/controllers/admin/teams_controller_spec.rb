require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::TeamsController do

  describe "GET 'index'" do
    before(:each) do
      @teams = [mock_model(Team)]
      Team.stub!(:paginate).and_return(@teams)
    end
    
    def doittoit
      get :index
    end
    
    it "is a success" do
      doittoit
      response.should be_success
    end
    
    it "paginates the teams" do
      Team.should_receive(:paginate).with(hash_including(:order => 'name')).and_return(@teams)
      doittoit
    end
  end
  
  describe "GET 'new'" do    
    
    def doittoit
      get :new
    end
    
    it "is a success" do
      doittoit
      response.should be_success
    end
    
    it "initializes a new team" do
      Team.should_receive(:new)
      doittoit
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @yellow_jackets_hash = {:name => 'The Yellow Jackets'}
      @yellow_jackets = mock_model(Team, @yellow_jackets_hash.merge(:save => true))
      Team.stub!(:new).and_return(@yellow_jackets)
    end
    
    def doittoit
      post :create, :team => @yellow_jackets_hash
    end
    
    it "initializes a new team" do
      Team.should_receive(:new).and_return(@yellow_jackets)
      doittoit
    end
    
    it "attempts to save the team" do
      @yellow_jackets.should_receive(:save).and_return(true)
      doittoit
    end
    
    describe "with successful save" do
      it "sets the flash message" do
        doittoit
        flash[:success].should eql("'The Yellow Jackets' was successfully added")
      end
      
      it "redirects to the index" do
        doittoit
        response.should redirect_to(admin_teams_path)
      end
    end
    
    describe "with failed save" do
      before(:each) do
        @yellow_jackets.stub!(:save).and_return(false)
        @yellow_jackets.stub!(:errors).and_return(mock('errors', :full_messages => 'you broke it!'))
      end
      
      it "sets the flash message" do
        doittoit
        flash[:error].should eql('you broke it!')
      end
      
      it "re-renders the new action" do
        controller.should_receive(:render).with(:new)
        doittoit
      end
    end
  end
  
  describe "GET 'edit'" do    
    before(:each) do
      @team = mock_model(Team)
      Team.stub!(:find).and_return(@team)
    end
    
    def doittoit
      get :edit, :team_id => 1
    end
    
    it "is a success" do
      doittoit
      response.should be_success
    end
    
    it "initializes a new team" do
      Team.should_receive(:find).with('1').and_return(@team)
      doittoit
    end
  end
end
