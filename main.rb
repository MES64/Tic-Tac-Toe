# frozen_string_literal: true

require_relative 'lib/board'
require_relative 'lib/game'

# Test Empty Board
board = Board.new
puts board
puts board.winner?
puts ''

# Test Rows
(0..2).each do |row|
  (0..2).each do |col|
    board.add('X', row, col)
    puts board
    puts board.winner?
    puts ''
  end
  puts board
  puts board.winner?
  puts ''

  (0..2).each do |col|
    board.add('O', row, col)
  end
  puts board
  puts board.winner?
  puts ''

  board.add('X', row, 0)
  puts board
  puts board.winner?
  puts ''
end

# Test Columns
board = Board.new
(0..2).each do |col|
  (0..2).each do |row|
    board.add('X', row, col)
  end
  puts board
  puts board.winner?
  puts ''

  (0..2).each do |row|
    board.add('O', row, col)
  end
  puts board
  puts board.winner?
  puts ''

  board.add('X', 0, col)
  puts board
  puts board.winner?
  puts ''
end

# Test Diagonal 1
board = Board.new
(0..2).each { |num| board.add('X', num, num) }
puts board
puts board.winner?
puts ''

(0..2).each { |num| board.add('O', num, num) }
puts board
puts board.winner?
puts ''

board.add('X', 0, 0)
puts board
puts board.winner?
puts ''

# Test Diagonal 2
board = Board.new
(0..2).each { |num| board.add('X', num, 2 - num) }
puts board
puts board.winner?
puts ''

(0..2).each { |num| board.add('O', num, 2 - num) }
puts board
puts board.winner?
puts ''

board.add('X', 0, 2)
puts board
puts board.winner?
puts ''
