# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Game holds info about the game state: board state, players, player turn, and result.
# It has methods for playing a turn and checking for game over
class Game
  def initialize
    @board = Board.new
    @players = [Player.new('X'), Player.new('O')]
    @player_turn = 0
    @result = nil
  end

  def play
    puts @board
    play_turn while @result.nil?
    puts @result
  end

  private

  def play_turn
    current_player = @players[@player_turn]
    current_player.place_token(@board.board)
    check_game_over(current_player)
    switch_player_turn
    puts @board
  end

  def check_game_over(current_player)
    # Only the player that has just moved can win the game
    return @result = "Player #{current_player.token} has won the game!" if current_player.winner?(@board.board)

    @result = 'Draw!' if @board.full?
  end

  def switch_player_turn
    @player_turn = 1 - @player_turn
  end
end
