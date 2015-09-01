require 'rqrcode_png'

class DealController < ApplicationController

  def index
    ###インテンドはスペース2に統一しよう。下の行のタブは使わない
    ###ホスト名などは、変更が変更がないところなので、共通関数としたほうがよいのではないか？
  	host = "http://" + request.host_with_port
    ###"/player/login" はlogin_pathで示すことができるのではないか
    @qr = RQRCode::QRCode.new(host + login_path + "?id=#{session[:deal_id]}", :level => :l).to_img.resize(200, 200).to_data_url
    @game_session = Deal.find(session[:deal_id])
    @db_numbers = @game_session.deal
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
    render layout: 'mylayout'
  end

  def update_event
    ###"deal_id = ? AND (reach_status = ? OR bingo_status = ?　はPlayerモデルにメソッドとしたらどうか？
    @player_list = Player.find_by_status(session[:deal_id])
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
    @deal = Deal.find(session[:deal_id])
    @deal_list = @deal.deal
    if (@deal_list.length < 75)
      while check_random_number_existed(@deal_list, deal_num = rand(1..75))
      end
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
end
