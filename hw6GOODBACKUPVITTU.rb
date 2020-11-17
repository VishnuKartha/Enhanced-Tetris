# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  All_My_Pieces =
                All_Pieces+
    
                 [rotations([[0, 0],[-1,-1], [-1, 0], [1, 0], [0, -1]]),  # T + 1
                 [[[0,0],[-1,0],[1,0],[2,0],[-2,0]],   # 5 long (only needs two) 
                 [[0,0],[0,-1],[0,1],[0,2],[0,-2]]],
            rotations([[0, 0], [1, 0],[0,-1]])] # Small L (3 blocks only)
 



  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end
  

end

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
  
  def next_piece
    if @cheat then
      @current_block = MyPiece.new([[[0,0]]],self)
      @cheat = false
    else
      @current_block= MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  def call_cheat
    if (@score >= 100 and !@cheat)
       @score -= 100
       @cheat = true
    end
  end
  
      

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

class MyTetris < Tetris
  # your enhancements here

    # creates a canvas and the board that interacts with it TMRW Have to fix the runtime error which is now caused by the running of the board
    def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
  
  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_clockwise
                 @board.rotate_clockwise})
    @root.bind('c', proc {@board.call_cheat})
  end
end
