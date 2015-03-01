class WelcomeController < ApplicationController
  def index
  	if session[:deal_id] == nil || Deal.all.empty?
  	  reset_session
  	  new_game = Deal.new(deal: Array.new)
  	  new_game.save!
  	  session[:deal_id] = new_game.id
  	end
  end
end