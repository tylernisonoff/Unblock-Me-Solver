require "set"
require "./board.rb"

# Simple BFS solver for Unblock me game
# Written by Tyler Nisonoff

def showSolution(board)
  history = []
  while board
    history.unshift(board)
    board = board.parent
  end
  puts "we'll start at the beginning and end at the end"
  puts "hit enter to click through"
  history.each do |b|
    b.print
    gets
  end
end

def solve(board)
  puts "\n...solving...\n\n\n"
  seen = Set.new()
  queue = []
  queue << board

  while !queue.empty?
    b = queue.shift
    if b.canPrisonerEscape?
      puts "---- SOLVED ----"
      showSolution(b)
      exit
    end

    next if seen.include?(b)

    seen.add(b)
    boards = b.generateAllBoards
    boards.each do |child|
        queue <<  child
    end
  end
  puts "queue empty"
end
