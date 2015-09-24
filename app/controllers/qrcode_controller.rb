require "rqrcode_png"

class QrcodeController < ApplicationController

  @@number_of_turn = 10

  def index
    if session[:deal_id] == nil
      new_game = Deal.create(deal: Array.new, number_of_turn: @@number_of_turn, tempwinner_number: Array.new)
      session[:deal_id] = new_game.id
    end
    host = "http://" + request.host_with_port
    @qr = RQRCode::QRCode.new(host + login_path + "?id=#{session[:deal_id]}", :level => :l).to_img.resize(200, 200).to_data_url
  end

  def update
  	set_number_of_turn params[:number_of_turn]
  end

  private

  def set_number_of_turn number
    @@number_of_turn = number
    render json: {message: "ok"},
    status: :ok
  end
end
