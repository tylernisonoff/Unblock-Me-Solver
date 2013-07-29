require "./block.rb"

class Board
  
  attr_accessor :board, :blocks, :lettersToUse, :width, :height, :parent, :prisoner
  
  def initialize(width, height)
    @width = width
    @height = height
    @board = Array.new(width) { Array.new(height, "  ") }
    @blocks = []
    @lettersToUse = ('a'..'z').to_a
  end

  def eql?(other)
    return false if self.width  != other.width
    return false if self.height != other.height

    self.board.each_with_index do |row, i|
      return false if !self.board[i].eql?(other.board[i])
    end
    return true
  end

  def hash
    hash = 0
    @board.each_with_index { |row, i| hash += row.hash*(10*(i+1)) } 
    return hash
  end

  # generates all possible boards that can arise out of a given board
  # returns array of all the boards
  def generateAllBoards
    boards = []
    @blocks.each do |block|
      x, y = block.x, block.y
      case block.type
      when VERTICAL
        if self.canMove?(block, UP)
          up = self.dup
          up.move(x, y, UP)
          up.parent = self
          boards << up
        end
        if self.canMove?(block, DOWN)
          down = self.dup
          down.move(x, y, DOWN)
          down.parent = self
          boards << down
        end
      when HORIZONTAL
        if self.canMove?(block, LEFT)
          left = self.dup
          left.move(x, y, LEFT)
          left.parent = self
          boards << left
        end
        if self.canMove?(block, RIGHT)
          right = self.dup
          right.move(x, y, RIGHT)
          right.parent = self
          boards << right
        end
      end
    end
    return boards
  end
  
  # returns true if the prisoner can escape
  def canPrisonerEscape?
    return false if !@prisoner
    x,y = @prisoner.position
    len = @prisoner.length

    return true if x+len == @width
    (x+len).upto(@width-1) do |z|
      return false if !@board[z][y].eql?("  ")
    end
    return true

  end
  
  # moves a block in a given direction by one space
  # void method
  def move(x,y, direction)
    # initialize block to something
    block = self.blocks[0]
    self.blocks.each do |b|
      block = b if b.x == x && b.y == y
    end
    letter = block.letter
    len    = block.length
    case direction
    when UP
      @board[x][y-1] = "#{letter}#{letter}"
      @board[x][y+len-1] = "  "
      block.y -= 1
    when DOWN
      @board[x][y+len] = "#{letter}#{letter}"
      @board[x][y] = "  "
      block.y += 1
    when LEFT
      @board[x-1][y] = "#{letter}#{letter}"
      @board[x+len-1][y] = "  "
      block.x -= 1
    when RIGHT
      @board[x+len][y] = "#{letter}#{letter}"
      @board[x][y] = "  "
      block.x += 1
    end
  end

  # adds a block to the board
  # block should be initialized with coordinates
  # void method
  def addBlock(block)
    @blocks << block
    
    letter = @lettersToUse.shift if !block.special
    if block.special
      letter = "@" 
      @prisoner = block 
    end
    block.board = self
    block.letter = letter

    x,y = block.position
    length = block.length

    case block.type
    when HORIZONTAL
      x.upto(x+length-1) do |w|
        @board[w][y] = "#{letter}#{letter}"
      end
    when VERTICAL
      y.upto(y+length-1) do |z|
        @board[x][z] = "#{letter}#{letter}"
      end
    end
  end

  # checks to see if a block can move in a certain direction
  # returns true if it can
  def canMove?(block, direction)
    type = block.type
    x, y, length = block.x, block.y, block.length

    case direction
    
    when UP
      return false if type == HORIZONTAL || y == 0
      return @board[x][y-1].eql?("  ")
    when DOWN
      return false if type == HORIZONTAL || y+length == @height
      return @board[x][y+length].eql?("  ")
    when LEFT
      return false if type == VERTICAL || x == 0
      return @board[x-1][y].eql?("  ")
    when RIGHT
      return false if type == VERTICAL || x+length == @width
      return @board[x+length][y].eql?("  ")
    end
  end

  def print
    puts "+"+( ["---"]*width).join()+"+"
    @board.each_with_index do |row, x|
      #puts "|"+row.join(" ")+" |"
      s = "|"
      row.each_with_index do |el, y|
        s+= @board[y][x]+" "
      end
      s+="|" if x != self.prisoner.y
      puts s
    end
    puts "+"+( ["---"]*width).join()+"+"
  end

  def dup
    new = Board.new(self.width, self.height)
    @blocks.each do |b|
      new.addBlock(Block.new(b.type, b.length, b.x,b.y,b.special))
    end
    new.lettersToUse = self.lettersToUse
    new.parent = self.parent
    return new
  end

end
