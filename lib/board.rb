# frozen_string_literal: true

# Board holds info about the token positions on the board grid.
# It has methods to detect if full, if winner, to print, and to update the board.
class Board
  BOARD_LENGTH = 3

  attr_accessor :board

  def initialize
    @board = Array.new(BOARD_LENGTH) { Array.new(BOARD_LENGTH, ' ') }
  end

  def to_s
    "#{row(0)}\n-----------\n#{row(1)}\n-----------\n#{row(2)}"
  end

  private

  def row(row_num)
    " #{@board.dig(row_num, 0)} | #{@board.dig(row_num, 1)} | #{@board.dig(row_num, 2)} "
  end
end
