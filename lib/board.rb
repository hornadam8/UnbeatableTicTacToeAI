class Board

  attr_accessor :cells



  def initialize
    self.cells = [" "," "," "," "," "," "," "," "," "]
  end

  def reset!
    @cells = [" "," "," "," "," "," "," "," "," "]
  end


  def display
    puts <<-DISPLAY
          " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
          "-----------"
          " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
          "-----------"
          " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
          DISPLAY

  end

  def input_to_index(num)
    num.to_i - 1
  end

  def position(num)
    self.cells[input_to_index(num)]
  end

  def update(i,player)
    i = input_to_index(i)
    self.cells[i] = player.token
  end

  def taken?(i)
    i = input_to_index(i)
    @cells[i] != " " ? true : false
  end

  def taken_and_equal(i,n)
    @cells[i] == @cells[n] && @cells[i] != " "
  end

  def valid_move?(i)
    i = input_to_index(i)
    self.cells[i] == " " && i > -1 && i < 9
  end

  def turn_count
    turns = []
    self.cells.each do |x|
      if x != " "
        turns << x
      end
    end
    turns.count
  end

  def current_player
    if self.turn_count.odd?
      "O"
    else
      "X"
    end
  end

  def turn
    puts "Select a space. 1-9, 1 for top-right, 9 for bottom left."
    i = self.input_to_index(gets)
    if self.valid_move?(i)
      self.move(i , self.current_player)
      self.display_board
    else
      self.turn
    end
  end



  def full?
    self.cells.include?(" ") ? false : true
  end



  def over?
    if self.draw?
      return true
    elsif self.won?
      return true
    else
      return false
    end
  end

  def winner
    WIN_COMBINATIONS.detect do |win_combo|
      if (@board[win_combo[0]]) == "X" && (@board[win_combo[1]]) == "X" && (@board[win_combo[2]]) == "X"
        return "X"
     elsif (@board[win_combo[0]]) == "O" && (@board[win_combo[1]]) == "O" && (@board[win_combo[2]]) == "O"
        return "O"
      else
        nil
      end
    end
  end

  def play
    until self.over?
      self.turn
    end
    if self.won?
      puts "Congratulations #{self.winner}!"
    elsif self.draw?
      puts "Cat's Game!"
    end
  end

  def center
    "5"
  end

  def corners
    ["1","3","7","9"]
  end

 def edges
   ["2","4","6","8"]
 end


end
