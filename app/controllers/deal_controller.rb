require 'rqrcode_png'

class DealController < ApplicationController
	
  def index
  	@all_numbers = Array.new
  	@host = request.host_with_port
    @qr = RQRCode::QRCode.new(@host + '/player/login', :level => :l).to_img.resize(200, 200).to_data_url
  	1.upto(75) do |number|
  	  @all_numbers << number
  	end
    
    render layout: 'mylayout'
  end

  def update_event
    @player_list = Player.where("reach_status = ? OR bingo_status = ? ",true,true);
    @response = Array.new
    @player_list.each do |element| 
      @response << {:name => element.name, :updated => element.updated_at, :reach => element.reach_status, :bingo => element.bingo_status}
    end
    respond_to do |format|
      format.json { render json: @response}
    end
  end

  def add
  	@number = params[:number].to_i
  	@deal = Deal.create(number: @number)
  	respond_to do |format|
  	  if @deal.save
        format.js {}
        format.json { render json: @deal}
      else
        format.json { render json: @deal.errors, status: :unprocessable_entity }
  	  end
  	end
  end
end
