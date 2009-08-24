class Admin::TeamsController < ApplicationController
  def index
    @teams = Team.paginate :page => params[:page], :order => 'name'
  end
  
  def new
    @team = Team.new
  end
  
  def create
    @team = Team.new(params[:team])
    
    respond_to do |wants|
      if @team.save
        flash[:success] = "'#{@team.name}' was successfully added"
        wants.html {redirect_to admin_teams_path}
      else
        flash[:error] = @team.errors.full_messages
        wants.html {render :new}
      end
    end
  end
  
  def edit
    @team = Team.find(params[:id], :include => 'users')
  end
  
  def update
    @team = Team.find(params[:id])
    
    respond_to do |wants|
      if @team.update_attributes(params[:team])
        flash[:success] = "'#{@team.name}' was successfully updated"
        wants.html {redirect_to :back}
      else
        flash[:error] = @team.errors.full_messages
        wants.html {render :edit}
      end
    end
  end
end
