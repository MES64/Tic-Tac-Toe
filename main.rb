# frozen_string_literal: true

require_relative 'lib/game'

game = Game.new
puts game.board
while game.result.nil?
  game.play_turn
  puts game.board
  game.check_game_over
end
puts game.result
