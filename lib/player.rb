# frozen_string_literal: true

require_relative 'board'

# Player holds info about the player token and if they have won
# It has a method for placing a token on the board
class Player
  def initialize(token)
    @token = token
    @win = false
  end

  def place_token(board)
    coords = [Board::BOARD_LENGTH, Board::BOARD_LENGTH] # Set coords so that first 'until' passes
    coords = [choose_coord('row'), choose_coord('column')] until board.board.dig(coords[0], coords[1]) == ' '
    board.board[coords[0]][coords[1]] = @token
  end

  private

  def choose_coord(row_or_col)
    puts "Player #{@token}, choose from #{row_or_col} 1, 2, 3:"
    coord = 0
    coord = gets.chomp.to_i until (1..Board::BOARD_LENGTH).include?(coord)
    coord - 1
  end
end
