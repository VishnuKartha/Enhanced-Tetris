# Vishnu Kartha
# Hw6tests

# This is the only file you turn in, so do not modify the other files as
# part of your solution.



require_relative './hw6provided'
require_relative './hw6assignment'

$game = MyTetris.new

$board = MyBoard.new($game)

# shows that the new pieces added are indeed the correct new blocks
MyPiece.next_piece($board)
MyPiece.next_piece($board)

MyPiece.next_piece($board)
MyPiece.next_piece($board)

MyPiece.next_piece($board)
MyPiece.next_piece($board)

MyPiece.next_piece($board)
MyPiece.next_piece($board)

$piece = MyPiece.next_piece($board)

# Both cases rotating once or twice
# SHOULD NOT CHANGE BASE
$piece.move(0,0,1)
$piece.move(0,0,1)
print($piece.position)
puts("")

$piece = MyPiece.next_piece($board)
$piece.move(0,0,2)
print($piece.position)
puts("")

#Base should move +1 in the column
$piece.move(0,1,0)
print($piece.position)
puts("")
# Base should move +1 in the row
$piece = MyPiece.next_piece($board)
$piece.move(1,0,0)
print($piece.position)
puts("")

