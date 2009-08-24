require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::LeaguesController do

  describe "GET 'index'" do
    before(:each) do
      @leagues = [mock_model(League)]
      League.stub!(:paginate).and_return(@leagues)
    end
    
    def doittoit
      get :index
    end
    
    it "is a success" do
      doittoit
      response.should be_success
    end
    
    it "paginates the leagues" do
      League.should_receive(:paginate).with(hash_including(:order => 'sport, season, name')).and_return(@leagues)
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
    
    it "initializes a new league" do
      League.should_receive(:new)
      doittoit
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @summer_league_hash = {:name => 'Summer League', :sport => 'Ultimate', :season => 'Summer'}
      @summer_league = mock_model(League, @summer_league_hash.merge(:save => true))
      League.stub!(:new).and_return(@summer_league)
    end
    
    def doittoit
      post :create, :league => @summer_league_hash
    end
    
    it "initializes a new league" do
      League.should_receive(:new).and_return(@summer_league)
      doittoit
    end
    
    it "attempts to save the league" do
      @summer_league.should_receive(:save).and_return(true)
      doittoit
    end
    
    describe "with successful save" do
      it "sets the flash message" do
        doittoit
        flash[:success].should eql("'Summer League' was successfully added")
      end
      
      it "redirects to the index" do
        doittoit
        response.should redirect_to(admin_leagues_path)
      end
    end
    
    describe "with failed save" do
      before(:each) do
        @summer_league.stub!(:save).and_return(false)
        @summer_league.stub!(:errors).and_return(mock('errors', :full_messages => mock('messages', :to_sentence => 'you broke it!')))
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
end
