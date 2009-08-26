class Admin::GamesController < ApplicationController
  before_filter :league_in_context
  
  def index
    @games = @league.games.paginate :page => params[:page], :order => 'start_time'
  end
  
  def new
    @game = @league.games.build
  end
  
  def create
    params[:game][:start_time] = params[:game_date] << " " << params[:game_time]
    @game = @league.games.build(params[:game])
    
    respond_to do |wants|
      if @game.save
        flash[:success] = "Game was successfully added"
        wants.html {redirect_to admin_league_games_path(@league)}
      else
        flash[:error] = @game.errors.full_messages.to_sentence
        wants.html {render :new}
      end
    end
  end
  
protected
  
  def league_in_context
    @league = League.find(params[:league_id])
    redirect_to( admin_leagues_path ) unless @league
  end
end