# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Game holds info about the game state: board state, players, player turn, and result.
# It has methods for playing a turn and checking for game over
class Game
  attr_reader :board, :result

  def initialize
    @board = Board.new
    @players = [Player.new('X'), Player.new('O')]
    @player_turn = 0
    @result = nil
  end

  def play_turn
    @players[@player_turn].place_token(@board.board)
    @player_turn = (@player_turn + 1) % 2
  end

  def check_game_over
    # Only the player that has just moved can win the game
    player_just_moved = @players[@player_turn - 1]
    return @result = "Player #{player_just_moved.token} has won the game!" if player_just_moved.winner?(@board.board)

    @result = 'Draw!' if @board.full?
  end
end
