require 'rqrcode_png'

class QrcodeController < ApplicationController
  def index
    @qr = RQRCode::QRCode.new("kienphan").to_img.resize(200, 200).to_data_url
  end
end
