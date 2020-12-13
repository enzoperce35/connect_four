require_relative 'connect_four.rb'

def start(game)
  while !game.won
    game.input = game.next_turn

    redo unless game.input.is_valid
    game.grid.update(game.input)

    game.check_coordinates

    puts game.board, game.status

    break if game.draw

    game.turn_count += 1
  end
end

#start(ConnectFour.new)  #commented for running rspec tests

