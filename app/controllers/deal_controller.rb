require "rqrcode_png"

class DealController < ApplicationController

  def index
    ###インテンドはスペース2に統一しよう。下の行のタブは使わない
    ###ホスト名などは、変更が変更がないところなので、共通関数としたほうがよいのではないか？
    random_tempwinner
    host = "http://" + request.host_with_port
    ###"/player/login" はlogin_pathで示すことができるのではないか
    @qr = RQRCode::QRCode.new(host + login_path + "?id=#{session[:game_id]}", :level => :l).to_img.resize(200, 200).to_data_url
    @db_numbers = Deal.find(session[:game_id]).deal
    @dealed_numbers = @db_numbers
    ###Group numbers in five groups
    @column_1, @column_2, @column_3, @column_4, @column_5 = [], [], [], [], []
    @dealed_numbers.each do |item|
      case item
        when 1..15 then @column_1<<item
        when 16..30 then @column_2<<item
        when 31..45 then @column_3<<item
        when 46..60 then @column_4<<item
        when 61..75 then @column_5<<item
      end
    end

    unless @db_numbers.empty?
      @current_number = @db_numbers.last
    end
    render layout: "application"
  end

  def create
    add
  end

  def update
    update_event
  end

  private

  def update_event
    ###"deal_id = ? AND (reach_status = ? OR bingo_status = ?　はPlayerモデルにメソッドとしたらどうか？
    @player_list = Player.find_by_status(session[:game_id])
    @response = Array.new
    @player_list.each do |element|
      timestamp = element.updated_at.strftime "%Y-%m-%d-%H:%m"
      @response << {:name => element.name, :updated => timestamp, :reach => element.reach_status, :bingo => element.bingo_status}
    end
    respond_to do |format|
      format.json { render json: @response}
    end
  end

  def add
    @deal = Deal.find(session[:game_id])
    @deal_list = @deal.deal
    if (@deal_list.length < 75)
      deal_num = PseudoRandomDeal @deal, @deal_list
      @deal.deal << deal_num
      respond_to do |format|
        if @deal.save
          format.js { render action: "add" }
          format.json { render json: @deal }
        end
      end
    else
      respond_to do |format|
        format.js { render action: "end"}
      end
    end
  end

  def check_random_number_existed(list, random)
    return list.include? random
  end

  def random_tempwinner
    current_game = Deal.find(session[:game_id])
    all_players = current_game.players
    count_players = all_players.count
    if count_players != 0
      tempwinner = all_players[rand(0..count_players-1)]
      current_game.tempwinner_number[0] = tempwinner.card[2][0]
      current_game.tempwinner_number[1] = tempwinner.card[2][1]
      current_game.tempwinner_number[2] = tempwinner.card[2][3]
      current_game.tempwinner_number[3] = tempwinner.card[2][4]
      current_game.save
    end
  end

  def PseudoRandomDeal current_game, deal_list
    current_turn = deal_list.count
    if current_turn == current_game.number_of_turn - 4
      if current_game.winnumber_type_2.count == 0 && current_game.winnumber_type_3.count == 0 && current_game.winnumber_type_4.count == 0
        tempwinner_number = current_game.tempwinner_number
        count = tempwinner_number.count
        return tempwinner_number[rand(0..count)]
      else 
        return Normal_random deal_list
      end
    elsif current_turn == current_game.number_of_turn - 3
      max_point = Find_max_point current_game
      if max_point == 4 || max_point == 3
        return Normal_random deal_list
      elsif max_point == 2
        winnumber_type_2 = current_game.winnumber_type_2
        count = winnumber_type_2.count
        return winnumber_type_2[rand(0..count)]
      end
    elsif current_turn == current_game.number_of_turn - 2
      max_point = Find_max_point current_game
      if max_point == 4
        return Normal_random deal_list
      elsif max_point == 3
        winnumber_type_3 = current_game.winnumber_type_3
        count = winnumber_type_3.count
        return winnumber_type_3[rand(0..count)]        
      end 
    elsif current_turn >= current_game.number_of_turn - 1
      winnumber_type_4 = current_game.winnumber_type_4
      count = winnumber_type_4.count
      return winnumber_type_4[rand(0..count)]
    else
      return Normal_random deal_list
    end
  end

  def Normal_random deal_list
    while check_random_number_existed(deal_list, deal_num = rand(1..75))
    end
    return deal_num
  end

  def Find_max_point current_game
    player_point_list = []
      all_players = current_game.players
      all_players.each do |player|
        player_point_list << player.player_point
      end
    return player_point_list.max
  end
end
