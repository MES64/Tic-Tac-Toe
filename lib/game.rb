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
    @player_turn = (@player_turn + 1) % 2
  end

  def winner?
    # Check rows, check cols, check diagonals
    win_rows?(@board.board) || win_rows?(@board.board.transpose) || win_diags?
  end

  def full?
    @board.board.flatten.none?(' ')
  end

  private

  def win_rows?(board)
    board.each { |row| return true if row.all?('X') || row.all?('O') }
    false
  end

  def win_diags?
    win_diag?(0, 2) || win_diag?(2, 0)
  end

  def win_diag?(start_col, end_col)
    diag = [@board.board.dig(0, start_col), @board.board.dig(1, 1), @board.board.dig(2, end_col)]
    diag.all?('X') || diag.all?('O')
  end
end
