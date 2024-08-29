# frozen_string_literal: true

# Board holds info about the token positions on the board grid.
# It has methods to detect if full, if winner, to print, and to update the board.
class Board
  BOARD_LENGTH = 3

  attr_accessor :board

  def initialize
    @board = Array.new(BOARD_LENGTH) { Array.new(BOARD_LENGTH, ' ') }
  end

  def winner?
    # Check rows, check cols, check diagonals
    win_rows?(@board) || win_rows?(@board.transpose) || win_diags?
  end

  def full?
    @board.flatten.none?(' ')
  end

  def to_s
    "#{row(0)}\n-----------\n#{row(1)}\n-----------\n#{row(2)}"
  end

  private

  def row(row_num)
    " #{@board.dig(row_num, 0)} | #{@board.dig(row_num, 1)} | #{@board.dig(row_num, 2)} "
  end

  def win_rows?(board)
    board.each { |row| return true if row.all?('X') || row.all?('O') }
    false
  end

  def win_diags?
    win_diag?(0, 2) || win_diag?(2, 0)
  end

  def win_diag?(start_col, end_col)
    diag = [@board.dig(0, start_col), @board.dig(1, 1), @board.dig(2, end_col)]
    diag.all?('X') || diag.all?('O')
  end
end
