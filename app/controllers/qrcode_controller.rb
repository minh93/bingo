require 'rqrcode_png'

class QrcodeController < ApplicationController
  @@qrCode = nil;
  def index
     @qr = RQRCode::QRCode.new("kienphan").to_img.resize(200, 200).to_data_url
     @@qrCode = @qr; 
  end
  def self.getQRCode
  	@@qrCode;
  end
end
