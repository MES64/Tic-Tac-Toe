# frozen_string_literal: true

# Board holds info about the token positions on the board grid.
# It has methods to detect if full, if winner, to print, and to update the board.
class Board
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
  end

  def add(token, row, col)
    @board[row][col] = token
  end

  def to_s
    "#{row(0)}\n-----------\n#{row(1)}\n-----------\n#{row(2)}"
  end

  private

  def row(row_num)
    " #{@board[row_num][0]} | #{@board[row_num][1]} | #{@board[row_num][2]} "
  end
end
