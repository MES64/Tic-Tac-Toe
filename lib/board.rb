# frozen_string_literal: true

# Board holds info about the token positions on the board grid.
# It has methods to detect if full, to_s, and to update the board.
class Board
  BOARD_LENGTH = 3

  attr_accessor :board

  def initialize(board = Array.new(BOARD_LENGTH) { Array.new(BOARD_LENGTH, ' ') })
    @board = board
  end

  def at(coords)
    return if coords.any?(&:negative?)

    board.dig(coords[0], coords[1])
  end

  def place_token(token, coords)
    board[coords[0]][coords[1]] = token
  end

  def full?
    board.flatten.none?(' ')
  end

  def print
    puts "#{row(0)}\n---+---+---\n#{row(1)}\n---+---+---\n#{row(2)}"
  end

  private

  def row(row_num)
    " #{board.dig(row_num, 0)} | #{board.dig(row_num, 1)} | #{board.dig(row_num, 2)} "
  end
end
