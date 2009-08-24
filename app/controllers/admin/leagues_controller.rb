class Admin::LeaguesController < ApplicationController
  def index
    @leagues = League.paginate :page => params[:page], :order => 'sport, season, name'
  end
  
  def new
    @league = League.new
  end
  
  def create
    @league = League.new(params[:league])
    
    respond_to do |wants|
      if @league.save
        flash[:success] = "'#{@league.name}' was successfully added"
        wants.html {redirect_to admin_leagues_path}
      else
        flash[:error] = @league.errors.full_messages.to_sentence
        wants.html {render :new}
      end
    end
  end
end
