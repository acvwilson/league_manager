require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::GamesController do
  before(:each) do
    @league = mock_model(League)
    League.stub!(:find).and_return(@league)
  end
  
  describe "GET 'index'" do
    before(:each) do
      @game = mock_model(Game)
      @mock_games = mock('association proxy', :paginate => [@game])
      @league.stub!(:games).and_return(@mock_games)
    end
    
    def doittoit
      get :index
    end
    
    it "is a success" do
      doittoit
      response.should be_success
    end
    
    it "paginates the league's games" do
      @league.should_receive(:games).and_return(@mock_games)
      @mock_games.should_receive(:paginate).with(hash_including(:order => 'start_time')).and_return([@game])
      doittoit
    end
  end
  
  describe "GET 'new'" do
    before(:each) do
      @game = mock_model(Game)
      @mock_games = mock('association proxy', :build => @game)
      @league.stub!(:games).and_return(@mock_games)
    end
    
    def doittoit
      get :new
    end
    
    it "is a success" do
      doittoit
      response.should be_success
    end
    
    it "builds a new game for the league" do
      @league.should_receive(:games).and_return(@mock_games)
      @mock_games.should_receive(:build).and_return(@game)
      doittoit
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @game_hash = {:home_team_id => 1, :away_team_id => 2}
      @game = mock_model(Game, @game_hash.merge(:save => true))
      @mock_games = mock('association proxy', :build => @game)
      @league.stub!(:games).and_return(@mock_games)    end
    
    def doittoit
      post :create, :game => @game_hash, :game_time => '18:00', :game_date => '2009-07-23'
    end
    
    it "initializes a new game" do
      @mock_games.should_receive(:build).and_return(@game)
      doittoit
    end
    
    it "attempts to save the game" do
      @game.should_receive(:save).and_return(true)
      doittoit
    end
    
    describe "with successful save" do
      it "sets the flash message" do
        doittoit
        flash[:success].should eql("Game was successfully added")
      end
      
      it "redirects to the index" do
        doittoit
        response.should redirect_to(admin_league_games_path(@league))
      end
    end
    
    describe "with failed save" do
      before(:each) do
        @game.stub!(:save).and_return(false)
        @game.stub!(:errors).and_return(mock('errors', :full_messages => mock('messages', :to_sentence => 'you broke it!')))
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
