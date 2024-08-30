# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Game holds info about the game state: board state, players, player turn, and if game is over.
# It has methods for playing a turn, checking for game over, and getting the result.
class Game
  def initialize
    @board = Board.new
    @players = [Player.new('X'), Player.new('O')]
    @player_turn = 0
    @game_over = false
  end

  def play_turn
    @players[@player_turn].place_token(@board)
    puts @board
    # Check end game
    @player_turn = (@player_turn + 1) % 2
  end
end
