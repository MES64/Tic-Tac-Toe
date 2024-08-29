# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/game'

board = Board.new

puts board
puts board.full?
puts ''

(0..2).each do |row|
  (0..2).each do |col|
    board.add('X', row, col)
    puts board
    puts board.full?
    puts ''
  end
end
