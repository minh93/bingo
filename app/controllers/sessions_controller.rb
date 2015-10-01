class SessionsController < ApplicationController
  def new
    unless Deal.where(:id => params[:id]).empty?
      session[:player_name] = nil if session[:game_id] != params[:id]
      session[:game_id] = params[:id]
      current_game = Deal.find(session[:game_id])
      @player_numbers = current_game.players.count
      if @player_numbers >= 100
        render "player/login_max_out"
      else
        if session[:player_name] != nil
          redirect_to player_path
        else
          @player = Player.new
          render layout: "application"
        end
      end
    else
      render "player/game_not_found"
    end
  end

  def create
    @game_session = Deal.find(session[:game_id])
    @player = @game_session.players.create(name: params[:session][:name], player_point: 0)
    if @player.save
      session[:player_name] = @player.name      
      redirect_to player_path
    else
      render :new, layout: "application"
    end
  end
end
