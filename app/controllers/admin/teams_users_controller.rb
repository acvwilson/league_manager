class Admin::TeamsUsersController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    @team = Team.find(params[:team_id])
    @user.teams << @team
    @user.save
    
    redirect_to edit_admin_team_path(@team)
  end
  
end