VERTICAL = 0
HORIZONTAL = 1

UP    = 0
DOWN  = 1
LEFT  = 2
RIGHT = 3

class Block
  attr_accessor :type, :length, :special, :x, :y, :board, :letter
  def initialize(direction, length,x,y, special = false)
    @type = direction
    @length = length
    @special = special
    self.setPosition(x,y)
  end

  # for vertical, set at topmost point
  # for horizontal set at leftmost point
  def setPosition(x,y)
    @x=x
    @y=y
  end

  def position
    [@x, @y]
  end

end
