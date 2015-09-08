class SessionsController < ApplicationController
  def new
    unless Deal.where(:id => params[:id]).empty?
      session[:game_id] = params[:id]
      @player_numbers = Player.count
      if @player_numbers >= 100
        render "login_max_out"
      else
        @player = Player.new
        render layout: "mylayout"
      end
    else
      render "player/game_not_found"
    end
  end

  def create
    @game_session = Deal.find(session[:game_id])
    @player = @game_session.players.create(name: params[:session][:name])
    if @player.save
      session[:player_name] = @player.name
      redirect_to player_path
    else
      render :new, layout: "mylayout"
    end
  end
end
