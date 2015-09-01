require "rqrcode_png"

class QrcodeController < ApplicationController
  def index
    if session[:deal_id] == nil
      new_game = Deal.create(deal: Array.new)
      session[:deal_id] = new_game.id
    end
    host = "http://" + request.host_with_port
    @qr = RQRCode::QRCode.new(host + login_path + "?id=#{session[:deal_id]}", :level => :l).to_img.resize(200, 200).to_data_url
  end
end
