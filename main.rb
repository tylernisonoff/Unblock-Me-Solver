require "./board.rb"
require "./solver.rb"

board = Board.new(6,6)
#
#add veritcal
board.add(Block.new(VERTICAL, 3, 0,0))
board.add(Block.new(VERTICAL, 2, 3,0))
board.add(Block.new(VERTICAL, 2, 5,0))
board.add(Block.new(VERTICAL, 3, 4,2))
board.add(Block.new(VERTICAL, 2, 5,3))
board.add(Block.new(VERTICAL, 2, 2,4))

#add horizontal
board.add(Block.new(HORIZONTAL, 2, 1,1))
board.add(Block.new(HORIZONTAL, 3, 0,3))
board.add(Block.new(HORIZONTAL, 2, 0,5))
board.add(Block.new(HORIZONTAL, 2, 3,5))

#add prisoner
board.add(Block.new(HORIZONTAL, 2, 2,2, true))
board.print
str = board.board

puts "\n The Prisoner is the @@ guy\n"
puts "\n Press enter to start \n"
gets

solve(board)

