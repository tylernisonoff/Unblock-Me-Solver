require "./board.rb"
require "./solver.rb"

board = Board.new(6,6)
#add horizontal
board.addBlock(Block.new(VERTICAL, 3, 0,0))
board.addBlock(Block.new(VERTICAL, 2, 3,0))
board.addBlock(Block.new(VERTICAL, 2, 5,0))
board.addBlock(Block.new(VERTICAL, 3, 4,2))
board.addBlock(Block.new(VERTICAL, 2, 5,3))
board.addBlock(Block.new(VERTICAL, 2, 2,4))

#add vertical
board.addBlock(Block.new(HORIZONTAL, 2, 1,1))
board.addBlock(Block.new(HORIZONTAL, 3, 0,3))
board.addBlock(Block.new(HORIZONTAL, 2, 0,5))
board.addBlock(Block.new(HORIZONTAL, 2, 3,5))

#add prisoner
board.addBlock(Block.new(HORIZONTAL, 2, 2,2, true))
board.print
str = board.board

puts "\n Press enter to start \n"
gets

solve(board)

