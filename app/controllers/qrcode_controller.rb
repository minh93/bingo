require 'rqrcode_png'

class QrcodeController < ApplicationController
  @@qrCode = nil;
  def index
<<<<<<< HEAD
     @qr = RQRCode::QRCode.new("kienphan").to_img.resize(200, 200).to_data_url
     @@qrCode = @qr; 
  end
  def self.getQRCode
  	@@qrCode;
=======
  	Deal.delete_all
  	Player.delete_all
  	@host = request.host_with_port
    @qr = RQRCode::QRCode.new(@host + '/player/login', :level => :l).to_img.resize(200, 200).to_data_url
>>>>>>> 91c8f6a49e2723a5dd087a169d44fdc30bbdc486
  end

end
