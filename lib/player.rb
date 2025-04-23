# frozen_string_literal: true

require_relative 'board'

# Player holds info about the player token
# It has methods for placing a token on the board and checking if they have won
class Player
  attr_accessor :token

  def initialize(token)
    @token = token
  end

  def make_move(board)
    coords = input_coords(board)
    place_token(coords, board)
  end

  def input_coords(board)
    loop do
      puts "Player #{@token}, choose the square to place your token"
      coords = [choose_coord('row'), choose_coord('column')]
      return coords if board.at(coords) == ' '

      puts 'Invalid Input: A token already exists there'
    end
  end

  def choose_coord(row_or_col)
    loop do
      puts "Choose from #{row_or_col} 1, 2, 3:"
      coord = gets.chomp
      return coord.to_i - 1 if coord.match?(/^[1-3]$/)

      puts 'Invalid Input: The coordinate must be from 1, 2, or 3'
    end
  end

  def place_token(coords, board)
    board.place_token(token, coords)
  end

  def winner?(board)
    # Check rows, check cols, check diagonals
    win_rows?(board) || win_rows?(board.transpose) || win_diags?(board)
  end

  private

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
