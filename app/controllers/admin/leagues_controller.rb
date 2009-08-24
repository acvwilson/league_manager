class Admin::LeaguesController < ApplicationController
  def index
    @leagues = League.paginate :page => params[:page], :order => 'start_date, name, sport'
  end
  
  def new
    @league = League.new
  end
  
  def show
    @league = League.find(params[:id], :include => :teams)
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
  
  def edit
    @league = League.find(params[:id], :include => :teams)
  end
  
  def update
    @league = League.find(params[:id])
    
    respond_to do |wants|
      if @league.update_attributes(params[:league])
        flash[:success] = "'#{@league.name}' was successfully updated"
        wants.html {redirect_to admin_leagues_path}
      else
        flash[:error] = @league.errors.full_messages.to_sentence
        wants.html {render :edit}
      end
    end
  end
end
