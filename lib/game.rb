class Game

  attr_accessor :board , :player_1 , :player_2

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize(p1 = Player::Human.new("X"), p2 = Player::Human.new("O"), b = Board.new)
    @player_1 = p1
    @player_2 = p2
    @board = b
  end

  def current_player
    self.board.turn_count.odd? ? @player_2 : @player_1
  end

  def won?
    WIN_COMBINATIONS.each do |win_combo|
      if @board.cells[win_combo[0]] == @board.cells[win_combo[1]] &&
        @board.cells[win_combo[1]] == @board.cells[win_combo[2]] &&
        @board.taken?(win_combo[0]+1)
        return win_combo
      end
    end
    return false
  end

  def draw?
    (@board.full? && !won?) ? true : false
  end

  def over?
    (draw? || won?) ? true : false
  end

  def winner
    WIN_COMBINATIONS.detect do |win_combo|
      if (@board.cells[win_combo[0]]) == "X" && (@board.cells[win_combo[1]]) == "X" && (@board.cells[win_combo[2]]) == "X"
        return "X"
      elsif (@board.cells[win_combo[0]]) == "O" && (@board.cells[win_combo[1]]) == "O" && (@board.cells[win_combo[2]]) == "O"
        return "O"
      else
        nil
      end
    end
  end

  def turn
    puts "Please enter a number 1-9:"
    @user_input = current_player.move(@board)
    if @board.valid_move?(@user_input)
      @board.update(@user_input, current_player)
    else puts "Please enter a number 1-9:"
      @board.display
      turn
    end
    @board.display
  end

  def play
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end




end
