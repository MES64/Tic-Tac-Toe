# frozen_string_literal: true

require_relative 'board'

# Player holds info about the player token
# It has methods for placing a token on the board and checking if they have won
class Player
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def place_token(board)
    coords = [Board::BOARD_LENGTH, Board::BOARD_LENGTH] # Set coords so that first 'until' passes
    coords = [choose_coord('row'), choose_coord('column')] until board.dig(coords[0], coords[1]) == ' '
    board[coords[0]][coords[1]] = @token
  end

  def winner?(board)
    # Check rows, check cols, check diagonals
    win_rows?(board) || win_rows?(board.transpose) || win_diags?(board)
  end

  private

  def choose_coord(row_or_col)
    puts "Player #{@token}, choose from #{row_or_col} 1, 2, 3:"
    coord = 0
    coord = gets.chomp.to_i until (1..Board::BOARD_LENGTH).include?(coord)
    coord - 1
  end

  def win_rows?(board)
    board.each { |row| return true if row.all?(@token) }
    false
  end

  def win_diags?(board)
    win_diag?(board, 0, 2) || win_diag?(board, 2, 0)
  end

  def win_diag?(board, start_col, end_col)
    diag = [board.dig(0, start_col), board.dig(1, 1), board.dig(2, end_col)]
    diag.all?(@token)
  end
end
