require 'rqrcode_png'

class QrcodeController < ApplicationController
  def index
  	@host = request.host_with_port
    @qr = RQRCode::QRCode.new(@host + '/player/login', :level => :l).to_img.resize(200, 200).to_data_url
  end

end
