class PlayerController < ApplicationController

  respond_to :html, :js

  def index
    @player = Player.find_by name: session[:player_name]
    if @player.card == nil
      @row = Array[0,0,1,0,0]
      @column = Array[0,0,1,0,0]  
      @diagonal = Array[1,1]
      @card = Array.new(5) { Array.new(5) }
      @card_status = Array.new(5) { Array.new(5) }
      i = 0
      j = 0
      random_number = 0
      for i in 0..4
        for j in 0..4
          @card[j][i] = -1;
          while check_existed_number_in_card(random_number = rand(15 * i + 1..15 * i + 15), j, i)
          end
          @card[j][i] = random_number
          @card_status[j][i] = 0
        end 
      end
      @card[2][2] = 0
      @player.card = @card
      @player.card_status = @card_status
      @player.row = @row
      @player.column = @column
      @player.diagonal = @diagonal
      @player.save

      render layout: 'mylayout'
    else
      @card = @player.card
      @card_status = @player.card_status
    end
  end

  def check_existed_number_in_card(number, j, i)
    tmp = 0;
    for tmp in 0..j
      if @card[tmp][i] == number
        return true;
      end
    end
    return false;
  end

  def login
    @player = Player.new
    render layout: 'mylayout'
  end

  def add
    @player = Player.create(params.require(:player).permit(:name))
    if @player.save
      session[:player_name] = @player.name
      redirect_to '/player/index'
    else
      render 'login'
    end
  end

  def check_number
    row = params[:row].to_i
    column = params[:column].to_i
    @number = params[:number].to_s
    if check_speaked_number(params[:number].to_i)
      @player = Player.find_by name: session[:player_name]
      @player.row[row] = @player.row[row] + 1
      @player.column[column] = @player.column[column]  + 1
      @player.card_status[row][column] = 1
      if row == column
        @player.diagonal[0] = @player.diagonal[0] + 1
      end
      if (row + column) == 4
        @player.diagonal[1] = @player.diagonal[1] + 1
      end
      @player.save
      if @player.row[row] == 5 || @player.column[column] == 5 || ((row == column || (row + column) == 4) && @player.diagonal[(row == column) ? 0 : 1] == 5 )
        respond_to do |format|
          format.js { render action: "bingo" }
          format.json { render json: @number }
        end
        return
      end      
      if @player.row[row] == 4 || @player.column[column] == 4 || ((row == column || (row + column) == 4) && @player.diagonal[(row == column) ? 0 : 1] == 4)
        respond_to do |format|
          format.js { render action: "reach" }
          format.json { render json: @number }
        end
        return
      end
      respond_to do |format|
        format.js {}
        format.json { render json: @number }
      end
    else
      respond_to do |format|
        format.js { render action: "error" }
      end
    end 
  end

=begin
  
//To do
  
=end
  def check_speaked_number(number)
   if Deal.exists?(:number => number)
      return true
    else
      return false
    end 
  end
  
  def reach
    @player = Player.find_by name: session[:player_name]
    if @player.reach_status != true
      @player.reach_status = true
      @player.save
    end
    respond_to do |format|
      format.js
    end
  end

  def bingo
    @player = Player.find_by name: session[:player_name]
    if @player.bingo_status != true
      @player.bingo_status = true
      @player.save
    end
    respond_to do |format|
      format.js
    end
  end

end
