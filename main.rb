# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/game'

board = Board.new
puts board

puts ''
board.add('X', 1, 2)
puts board

puts ''
board.add('O', 2, 0)
puts board
