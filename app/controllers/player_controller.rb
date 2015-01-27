class PlayerController < ApplicationController

  respond_to :html, :js

  def index
    @@row = Array[0,0,1,0,0]
    @@column = Array[0,0,1,0,0]  
    @@diagonal = Array[1,1]
    @card = Array.new(5) { Array.new(5) }
    $i = 0
    $j = 0
    random_number = 0
    for $i in 0..4
      for $j in 0..4
        @card[$j][$i] = -1;
        while check_existed_number_in_card(random_number = rand(15 * $i + 1..15 * $i + 15), $j, $i)
        end
        @card[$j][$i] = random_number;
      end 
    end
    @card[2][2] = 0;
    render layout: 'mylayout'
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
    if check_speaked_number(0,0) 
      @@row[row] = @@row[row] + 1
      @@column[column] = @@column[column] + 1
      if row == column
        @@diagonal[0] = @@diagonal[0] + 1
      end
      if (row + column) == 4
        @@diagonal[1] = @@diagonal[1] + 1
      end
      if check_status(row,column) == "bingo"
        respond_to do |format|
          format.js { render action: "bingo" }
          format.json { render json: @number }
        end
        return
      end      
      if check_status(row,column) == "reach"
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

  def check_speaked_number(row, column)
    return true
  end

  def check_status(row, column)
    row_num_count = @@row[row]
    col_num_count = @@column[column]
    row_status = check_status_row_col(row_num_count)
    col_status = check_status_row_col(col_num_count)
    diagonal_status = check_status_diagonal(row,column)
    if row_status == "bingo" || col_status == "bingo" || diagonal_status == "bingo"
      return "bingo"
    elsif row_status == "reach" || col_status == "reach" || diagonal_status == "reach"
      return "reach"
    end
  end

  def check_status_row_col(count)
    case count
    when 4
      return "reach"
    when 5
      return "bingo"
    end
  end

  def check_status_diagonal(row,column)
    count = @@diagonal[row == column ? 0 : 1]
    if row == column || row + column == 4
      if count == 5
        return "bingo"
      elsif count == 4
        return "reach"
      end
    end
  end

  def reach

    respond_to do |format|
      format.js
    end
  end

  def bingo
    respond_to do |format|
      format.js
    end
  end

end
