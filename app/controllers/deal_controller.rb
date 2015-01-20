class DealController < ApplicationController
	
  def index
  	@all_numbers = Array.new
  	@host = request.host_with_port
    @qr = RQRCode::QRCode.new(@host).to_img.resize(100, 100).to_data_url
  	1.upto(75) do |number|
  	  @all_numbers << number
  	end
  end

  def add
  	@number = params[:number].to_i
  	@deal = Deal.create(number: @number)
  	response_to do |format|
  	  if @deal.save!
  	    format.html { redirect_to @deal, notice: 'User was successfully created.' }
        format.js   {}
        format.json { render json: @deal, status: :created, location: @deal }
      else
      	format.html { render action: "new" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
  	  end
  	end
  end
end
