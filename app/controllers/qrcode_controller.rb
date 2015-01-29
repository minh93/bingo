require 'rqrcode_png'

class QrcodeController < ApplicationController
  def index
  	@host = request.host_with_port
    #@qr = RQRCode::QRCode.new(@host + '/player/login', :level => :h).to_img.resize(200, 200).to_data_url
    qr_size = 3
    @qr = nil
    while @qr == nil && qr_size < 10
      begin
        @qr = RQRCode::QRCode.new(@host + '/player/login', :size => qr_size, :level => :l)
      rescue RQRCode::QRCodeRunTimeError => e
        qr_size += 1
      end
    end
  end
  
end
