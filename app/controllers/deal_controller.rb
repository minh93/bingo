require 'rqrcode_png'

class DealController < ApplicationController
	
  def index
  	@dealed_numbers = Array.new
  	@host = request.host_with_port
    @qr = RQRCode::QRCode.new(@host + '/player/login', :level => :l).to_img.resize(200, 200).to_data_url
    db_numbers = Deal.all
    db_numbers.each {|element| @dealed_numbers << element.number}
    @current_number = Deal.last
    render layout: 'mylayout'
  end

  def update_event
    @player_list = Player.where("reach_status = ? OR bingo_status = ? ",true,true).order("updated_at ASC");
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
    while check_random_number_existed(deal_num = rand(1..75)) 
    end
    @deal = Deal.create(number: deal_num)
    respond_to do |format|
      if @deal.save
        format.js { render action: "add" }
        format.json { render json: @deal }
      else
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_random_number_existed(random)
    num = Deal.find_by number: random
    if num == nil
      return false
    else
      return true
    end
  end
end
