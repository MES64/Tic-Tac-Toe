# frozen_string_literal: true

# Board holds info about the token positions on the board grid.
# It has methods to detect if full, if winner, to print, and to update the board.
class Board
  def initialize
    @board = Array.new(3) { Array.new(3) }
  end
end
