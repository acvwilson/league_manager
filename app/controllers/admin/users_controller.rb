class Admin::UsersController < ApplicationController
  def index
    @users = User.paginate :page => params[:page], :order => 'last_name'
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    respond_to do |wants|
      if @user.save!
        flash[:success] = "#{@user.name} was successfully added"
        wants.html {redirect_to admin_users_path}
      else
        flash[:error] = @user.errors.full_messages
        wants.html {render :new}
      end
    end
  end
end
