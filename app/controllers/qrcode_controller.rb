require "rqrcode_png"

class QrcodeController < ApplicationController  

  def index
    if session[:number_of_turn].nil?
      @number_of_turn = 10
    else
      @number_of_turn = session[:number_of_turn]
    end

    if session[:game_id].nil?
      new_game = Deal.create(deal: Array.new, number_of_turn: @number_of_turn, tempwinner_number: Array.new, winnumber_type_2: Array.new, winnumber_type_3: Array.new, winnumber_type_4: Array.new)
      session[:game_id] = new_game.id      
    end
    host = "http://" + request.host_with_port
    @qr = RQRCode::QRCode.new(host + login_path + "?id=#{session[:game_id]}", :level => :l).to_img.resize(200, 200).to_data_url
  end

  def update
  	set_number_of_turn params[:number_of_turn]
  end

  private

  def set_number_of_turn number
    session[:number_of_turn] = number
    render json: {message: "ok"},
    status: :ok
  end
end
