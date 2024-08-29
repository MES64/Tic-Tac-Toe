# frozen_string_literal: true

require_relative 'board'

# Game holds info about the game state: board state, player turn, and the result.
# It has methods for playing a turn, checking for game over, and getting the result.
class Game
  def initialize
    @board = Board.new
    @player_turn = 'X'
    @result = nil
  end
end
