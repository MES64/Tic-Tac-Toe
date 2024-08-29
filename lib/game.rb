# frozen_string_literal: true

require_relative 'board'

# Game holds info about the game state: board state, player turn, and the result.
# It has methods for placing the token, checking for game over, and getting the result.
class Game
  def initialize
    @board = Board.new
    @player_turn = 'X'
    @result = nil
  end

  def place_token
    coords = [4, 4] # Set coords so that first 'until' passes
    coords = [choose_coord('row'), choose_coord('column')] until @board.board.dig(coords[0], coords[1]) == ' '
    @board.board[coords[0]][coords[1]] = @player_turn
    puts @board
  end

  private

  def choose_coord(row_or_col)
    puts "Player #{@player_turn}, choose from #{row_or_col} 1, 2, 3:"
    coord = 0
    coord = gets.chomp.to_i until (1..Board::BOARD_LENGTH).include?(coord)
    coord - 1
  end
end
