require 'rqrcode_png'
class GameController < ApplicationController

  def index
  	@qr= QrcodeController.getQRCode();
  end
end
