require 'rqrcode_png'

class QrcodeController < ApplicationController
  def index
  	#Deal.delete_all
  	#Player.delete_all
  	@host = request.host_with_port
    @qr = RQRCode::QRCode.new(@host + "/player/login?id=#{session[:deal_id]}", :level => :l).to_img.resize(200, 200).to_data_url
  end
end
