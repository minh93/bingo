class PlayerController < ApplicationController
<<<<<<< HEAD
  respond_to :html, :js
  @card = nil;
  @player = nil;
  # @@row = Array[0,0,1,0,0]
  # @@colume = Array[0,0,1,0,0] 
  # @@diagonal = Array[1,1]
  def index
    @@row = Array[0,0,1,0,0]
    @@colume = Array[0,0,1,0,0] 
    @@diagonal = Array[1,1]
    @card = Array.new(5) {  Array.new(5)  }
  	$i=0
  	$j=0
  	tmp=0
  	for $i in 0..4
  		for $j in 0..4
        @card[$j][$i] = -1;
        while checkExistedNumberInCard((tmp=rand(15*$i+1..15*$i+15)),$j,$i) == true
        end
        @card[$j][$i] = tmp;
      end 
 		end
    @card[2][2] = 0;
 	end	

############################################
=begin
 This function check random number is existed in card 
=end

  def checkExistedNumberInCard(num, j, i)
    tmp=0;
    for tmp in 0..j
     if @card[tmp][i] == num
      return true;
     end
=======

  respond_to :html, :js

  def index
    @row = Array[0,0,1,0,0]
    @column = Array[0,0,1,0,0]  
    @diagonal = Array[1,1]
    @card = Array.new(5) { Array.new(5) }
    i = 0
    j = 0
    random_number = 0
    for i in 0..4
      for j in 0..4
        @card[j][i] = -1;
        while check_existed_number_in_card(random_number = rand(15 * i + 1..15 * i + 15), j, i)
        end
        @card[j][i] = random_number;
      end 
    end
    @card[2][2] = 0
    @player = Player.find_by name: session[:player_name]
    @player.card = [@card[0], @card[1], @card[2], @card[3], @card[4]]
    @player.row = @row
    @player.column = @column
    @player.diagonal = @diagonal
    @player.save

    render layout: 'mylayout'
  end

  def check_existed_number_in_card(number, j, i)
    tmp = 0;
    for tmp in 0..j
      if @card[tmp][i] == number
        return true;
      end
>>>>>>> 91c8f6a49e2723a5dd087a169d44fdc30bbdc486
    end
    return false;
  end

<<<<<<< HEAD
####################################
=begin
  This funtion process player selected number and response corresponds ajax request
=end
  
  def checkNumber 
    row = params[:row].to_i
    colume = params[:colume].to_i
    @number = params[:number].to_s
    if checkSpeakedNumber(0,0) == true
      @@row[row] = @@row[row] +1
      @@colume[colume] = @@colume[colume] + 1
      
      if row==colume
        @@diagonal[0] = @@diagonal[0] + 1
      end
      if (row+colume) == 4
        @@diagonal[1] = @@diagonal[1] + 1
      end
      
      if @@row[row] == 5 || @@colume[colume] == 5  || ((row == colume || row+colume == 4 )&& @@diagonal[row==colume ? 0 : 1] == 5 )
        respond_to do |format|
          format.js {render :action => "bingo"}
          format.json {render json: @number}
        end
        return
      end
      
      if @@row[row] == 4 || @@colume[colume] == 4  || ((row == colume || row+colume ==4 ) && @@diagonal[row==colume ? 0 : 1] == 4 )
        respond_to do |format|
          format.js {render :action => "reach"}
          format.json {render json: @number}
=======
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
>>>>>>> 91c8f6a49e2723a5dd087a169d44fdc30bbdc486
        end
        return
      end
      respond_to do |format|
        format.js {}
<<<<<<< HEAD
        format.json {render json: @number}
      end
    else
      respond_to do |format|
        format.js {render :action => "error"}
      end
    end

  end

  def reach
=======
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
>>>>>>> 91c8f6a49e2723a5dd087a169d44fdc30bbdc486
    respond_to do |format|
      format.js
    end
  end

  def bingo
<<<<<<< HEAD
=======
    @player = Player.find_by name: session[:player_name]
    if @player.bingo_status != true
      @player.bingo_status = true
      @player.save
    end
>>>>>>> 91c8f6a49e2723a5dd087a169d44fdc30bbdc486
    respond_to do |format|
      format.js
    end
  end
<<<<<<< HEAD
###################################
=begin
  This function check the Player selected number is lastet number of Dealer speaked
  
  params row,colume  # the position of Player selected number
  return true        # the number is lastes number of Dealer speaked 
          fail       # the number is not lastes number of Dealer speaked

=end
def checkSpeakedNumber(row, colume)
  
  return true  

end

####################################
=begin
 This funtion to show all Player 
=end

  def show
    @player = Player.all

  end

#####################################
=begin
  This function initialize new Player Model 
=end

  def new
    @player = Player.new 
  end
#########################################  
=begin
  This funtion create new player 
=end

  def create
    @player = Player.new(player_params)  
    if @player.save
      flash[:success] = "Welcome to the Bingo App!"
      redirect_to '/player/index'
    else
      render 'new'
    end
  end 
  def player_params
    params.require(:player).permit(:name)
  end
end
=======

end
>>>>>>> 91c8f6a49e2723a5dd087a169d44fdc30bbdc486
