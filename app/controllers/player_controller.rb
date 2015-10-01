class PlayerController < ApplicationController

  respond_to :html, :js

  def show
    @player = Player.find_by_deal_and_name(session[:game_id] , session[:player_name])
    current_game = Deal.find(session[:game_id])
    if @player.card == nil
      ### player row、columnの役割がよく見えてきません。説明をお願いします。
      ### この初期化の配列の大きさなどはまとめて定義できないか？今後メンテナンスしていくのが大変そう　
      @player.row = Array[0,0,1,0,0]
      @player.column = Array[0,0,1,0,0]
      @player.diagonal = Array[1,1]
      @player.card = Array.new(Player::CARD_SIZE) { Array.new(Player::CARD_SIZE) }
      @player.card_status = Array.new(Player::CARD_SIZE) { Array.new(Player::CARD_SIZE) }
      ### 5 や 0..4 などは固定値なので、別で定義したほうがよさそう、もしくはCardモデルの作成も検討しよう
      i = Player::BEGIN_CARD_INDEX
      j = Player::BEGIN_CARD_INDEX
      random_number = 0
      for i in Player::BEGIN_CARD_INDEX..Player::END_CARD_INDEX
        for j in Player::BEGIN_CARD_INDEX..Player::END_CARD_INDEX
          @player.card[j][i] = -1;
          while check_existed_number_in_card(random_number = rand(15 * i + 1..15 * i + 15), j, i)
          end
          @player.card[j][i] = random_number
          @player.card_status[j][i] = 0
        end
      end
      @player.card[2][2] = 0
      @player.card_status[2][2] = 1;
      @player.save
      if current_game.tempwinner_number.count == 0
        current_game.tempwinner_number[0] = @player.card[2][0]
        current_game.tempwinner_number[1] = @player.card[2][1]
        current_game.tempwinner_number[2] = @player.card[2][3]
        current_game.tempwinner_number[3] = @player.card[2][4]
        current_game.save
      end
      render layout: "application"
    else
      render layout: "application"
    end
  end

  def update
    if params[:type_of_action] == "reach"
      reach
    elsif params[:type_of_action] == "bingo"
      bingo
    elsif params[:type_of_action] == "check_number"
      check_number
    elsif params[:type_of_action] == "update_deal_numbers"
      update_deal_numbers
    elsif params[:type_of_action] == "check_spoke_number"
      check_spoke_number params[:number]
    end
  end

  private

  def check_existed_number_in_card(number, j, i)
    tmp = 0;
    for tmp in 0..j
      if @player.card[tmp][i] == number
        return true;
      end
    end
    return false;
  end

  def check_number
    row = params[:row].to_i
    column = params[:column].to_i
    @number = params[:number].to_s
    current_game = Deal.find(session[:game_id])
    @player = Player.find_by_deal_and_name(session[:game_id] , session[:player_name])
    @player.row[row] = @player.row[row] + 1
    @player.column[column] = @player.column[column] + 1
    @player.card_status[row][column] = 1
    if params[:player_point].to_i > @player.player_point
      @player.player_point = params[:player_point].to_i
    end
    if row == column
        @player.diagonal[0] = @player.diagonal[0] + 1
    elsif (row + column) == 4
        @player.diagonal[1] = @player.diagonal[1] + 1
    end
    @player.save
    if params[:winnumber] != nil
      params[:winnumber].each do |item|
        temp_item = item.split('-')
        temp_item[0] = temp_item[0].to_i
        temp_item[1] = temp_item[1].to_i
        if temp_item[1] == 4
          unless current_game.winnumber_type_4.include? temp_item[0]
            current_game.winnumber_type_4 << temp_item[0]
            current_game.winnumber_type_3.delete(temp_item[0])
            current_game.winnumber_type_2.delete(temp_item[0])
          end
        elsif temp_item[1] == 3
          unless current_game.winnumber_type_4.include? temp_item[0]
            unless current_game.winnumber_type_3.include? temp_item[0]
              current_game.winnumber_type_3 << temp_item[0]
              current_game.winnumber_type_2.delete(temp_item[0])
            end
          end
        elsif temp_item[1] == 2
          unless current_game.winnumber_type_4.include? temp_item[0]
            unless current_game.winnumber_type_3.include? temp_item[0]
              unless current_game.winnumber_type_2.include? temp_item[0]
                current_game.winnumber_type_2 << temp_item[0]
              end
            end
          end
        end    
      end
    end
    if @player.row[row] == 5 || @player.column[column] == 5 || ((row == column || (row + column) == 4) && @player.diagonal[(row == column) ? 0 : 1] == 5 )
      current_game.winnumber_type_2.delete(@number.to_i)
      current_game.winnumber_type_3.delete(@number.to_i)
      current_game.winnumber_type_4.delete(@number.to_i)
      current_game.tempwinner_number.delete(@number.to_i)
      current_game.save
      respond_to do |format|
        format.js { render action: "bingo" }
        format.json { render json: @number }
      end
    elsif @player.row[row] == 4 || @player.column[column] == 4 || ((row == column || (row + column) == 4) && @player.diagonal[(row == column) ? 0 : 1] == 4)
      current_game.winnumber_type_2.delete(@number.to_i)
      current_game.winnumber_type_3.delete(@number.to_i)
      current_game.winnumber_type_4.delete(@number.to_i)
      current_game.tempwinner_number.delete(@number.to_i)
      current_game.save
      respond_to do |format|
        format.js { render action: "reach" }
        format.json { render json: @number }
      end
    else
      current_game.winnumber_type_2.delete(@number.to_i)
      current_game.winnumber_type_3.delete(@number.to_i)
      current_game.winnumber_type_4.delete(@number.to_i)
      current_game.tempwinner_number.delete(@number.to_i)
      current_game.save
      respond_to do |format|
        format.js { render action: "check" }
        format.json { render json: @number }
      end
    end
  end

=begin

//To do

=end
  def check_spoke_number number
    @game_session = Deal.find(session[:game_id])
    deal_list = @game_session.deal
    if deal_list.include? number.to_i
      render json: {message: "ok"},
      status: :ok
    else
      respond_to do |format|
        format.js { render action: "error" }
        format.json { render json: @number }
      end
    end
  end

  def reach
    #@player = Player.find_by name: session[:player_name]
    @player = Player.find_by_deal_and_name(session[:game_id] , session[:player_name])
    if @player.reach_status != true
      @player.reach_status = true
      @player.save
    end
    respond_to do |format|
      format.js
    end
  end

  def bingo
    @player = Player.find_by_deal_and_name(session[:game_id] , session[:player_name])
    if @player.bingo_status != true
      @player.bingo_status = true
      @player.save
    end
    respond_to do |format|
      format.js
    end
  end

  def update_deal_numbers
    unless session[:game_id].nil?
      @game_session = Deal.find(session[:game_id])
      @response = @game_session.deal
    end
    respond_to do |format|
      format.json { render json: @response}
    end
  end

  def player_params
    params.require(:player).permit(:name)
  end
end
