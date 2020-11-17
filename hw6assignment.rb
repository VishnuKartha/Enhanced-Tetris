# Vishnu Kartha's Hw 6 Assignment
# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.


# class responsible for the pieces and their movements
class MyPiece < Piece
  # class array holding all the original pieces plus the new custom pieces
  All_My_Pieces =
                 All_Pieces+
    
                 [rotations([[0, 0],[-1,-1], [-1, 0], [1, 0], [0, -1]]),  # T + 1 extra block
                 [[[0,0],[-1,0],[1,0],[2,0],[-2,0]],   # 5 long block (only needs two) 
                 [[0,0],[0,-1],[0,1],[0,2],[0,-2]]],
                  rotations([[0, 0], [1, 0],[0,-1]])] # small L block  
  #gets the next  MyPiece to be used
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end
end

# class responsible for the interaction between the pieces and the game itself
class MyBoard < Board
  # your enhancements here
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @cheat = false
  end
  
 # gets the next MyPiece to be used
  def next_piece
    if @cheat then
      @current_block = MyPiece.new([[[0,0]]],self)
      @cheat = false
    else
      @current_block= MyPiece.next_piece(self)
    end
    @current_pos = nil
  end
  
# allows the user to use the cheat command
  def call_cheat
    if (@score >= 100 and !@cheat)
       @score -= 100
       @cheat = true
    end
  end
        
 # stores the current tetris piece
 def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
     # stores each "subblock" of each tetris object. Now as all the number of all subblocks are not all equal to four we have to change it 
     (0..(locations.length - 1)).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end      
end

# class responsible for one game of tetris
class MyTetris < Tetris
    # creates a canvas and the board that interacts with it
    def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
    end
    
  # adds the 'u' and 'c' extra key functionality to the original game
  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_clockwise
                 @board.rotate_clockwise})
    @root.bind('c', proc {@board.call_cheat})
  end
end
