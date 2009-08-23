require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::UsersController do

  describe "GET 'index'" do
    before(:each) do
      @users = [mock_model(User)]
      User.stub!(:paginate).and_return(@users)
    end
    
    def doittoit
      get :index
    end
    
    it "is a success" do
      doittoit
      response.should be_success
    end
    
    it "paginates the users" do
      User.should_receive(:paginate).with(hash_including(:order => 'last_name')).and_return(@users)
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
    
    it "initializes a new user" do
      User.should_receive(:new)
      doittoit
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @james_hash = {:first_name => 'James', :last_name => 'Dean', :rank => '9'}
      @james = mock_model(User, @james_hash.merge(:save! => true, :name => 'James Dean'))
      User.stub!(:new).and_return(@james)
    end
    
    def doittoit
      post :create, :user => @james_hash
    end
    
    it "initializes a new user" do
      User.should_receive(:new).and_return(@james)
      doittoit
    end
    
    it "attempts to save the user" do
      @james.should_receive(:save!).and_return(true)
      doittoit
    end
    
    describe "with successful save" do
      it "sets the flash notice" do
        doittoit
        flash[:notice].should eql('James Dean was successfully added')
      end
      
      it "redirects to the index" do
        doittoit
        response.should redirect_to(admin_users_path)
      end

    end
  end
end
