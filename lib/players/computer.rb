require_relative "../player.rb"

class Player::Computer < Player

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def move(board)
    @board = board
    @input = " "
    WIN_COMBINATIONS.each do |combo|
      if @board.taken_and_equal(combo[0],combo[1]) && !@board.taken?((combo[2]+1).to_s)
        @input = combo[2]
      elsif @board.taken_and_equal(combo[1],combo[2]) && !@board.taken?((combo[0]+1).to_s)
        @input = combo[0]
      elsif @board.taken_and_equal(combo[0],combo[2]) && !@board.taken?((combo[1]+1).to_s)
        @input = combo[1]
      end
    end
    if (@input == " ") && !@board.taken?(@board.center)
      @input = 4
    elsif (@input == " ") && @board.taken?(@board.center)
      @board.corners.each do |corner|
        if !@board.taken?(corner)
          @input = corner.to_i - 1
        end
      end
    end
    if (@input == " ")
      @board.edges.each do |edge|
        if !@board.taken?(edge)
          @input = edge.to_i - 1
        end
      end
    end
    @move = @input + 1
    @move.to_s
  end


end
