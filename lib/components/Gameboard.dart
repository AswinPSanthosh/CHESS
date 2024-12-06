import 'package:chess/Model.dart';
import 'package:chess/Square.dart';
import 'package:chess/components/chesspiece.dart';
import 'package:chess/components/colors.dart';
import 'package:chess/components/deadpiece.dart';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({super.key});
  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Chesspiece? selectedPiece;
  int selectedRow = -1;
  int selectedCol = -1;
  bool isWhiteturn = true;
  List<Chesspiece> blackPieceCaptured = [];
  List<Chesspiece> whitePieceCaptured = [];
  List<int> whiteKing = [7, 3];
  List<int> blackKing = [0, 4];
  bool checkStatus = false;
  late List<List<Chesspiece?>> board;

  void initState() {
    super.initState();
    _initialiseBoard();
  }

void pieceSelected(int row, int col) {
  setState(() {
    if (selectedPiece == null && board[row][col] != null) {
      if (board[row][col]!.iswhite == isWhiteturn) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
        validMoves = realValidmoves(selectedRow, selectedCol, selectedPiece, true);
      }
    } else if (board[row][col] != null && board[row][col]!.iswhite == selectedPiece!.iswhite) {
      selectedPiece = board[row][col];
      selectedRow = row;
      selectedCol = col;
      validMoves = realValidmoves(selectedRow, selectedCol, selectedPiece, true);
    } else if (selectedPiece != null &&
        validMoves.any((move) => move[0] == row && move[1] == col)) {
      movePiece(row, col);

    }
  });
}

// Function to check for stalemate
bool stalemate(bool isWhite) {
  // Check if the king is not in check
  if (isKingCheck(isWhite)) return false;

  // Check if there are any valid moves for any piece
  for (int row = 0; row < 8; row++) {
    for (int col = 0; col < 8; col++) {
      Chesspiece? piece = board[row][col];
      if (piece != null && piece.iswhite == isWhite) {
        List<List<int>> moves = realValidmoves(row, col, piece, true);
        if (moves.isNotEmpty) return false;
      }
    }
  }

  return true; // No moves left, and king is not in check
}



// Show an endgame dialog
void showEndGameDialog(String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initialiseBoard();
            },
            child: const Text("Restart"),
          ),
        ],
      );
    },
  );
}

List<List<int>> realValidmoves(int row, int col, Chesspiece? piece, bool checkSimulation) {
    List<List<int>> candidateMoves = rowValidmoves(row, col, piece);
    if (checkSimulation) {
      return candidateMoves
          .where((move) => simulateMovesSafe(piece!, row, col, move[0], move[1]))
          .toList();
    }
    return candidateMoves;
  }


// calculate row valid moves
  List<List<int>> rowValidmoves(int row, int col, Chesspiece? piece) {
    List<List<int>> candidateMOves = [];

    int direction = piece!.iswhite ? -1 : 1;


    switch (piece.type) {
      case ChessPieceType.pawn:
        //going one stepp up

        if (isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMOves.add([row + direction, col]);
        }

        // going 2 moves
        if ((row == 1 && !piece.iswhite) || (row == 6 && piece.iswhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMOves.add([row + 2 * direction, col]);
          }
        }

        // kill diagonally
        // killing in left direction
        if (isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.iswhite != piece.iswhite) {
          candidateMOves.add([row + direction, col - 1]);
        }

// killing in right direction
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.iswhite != piece.iswhite) {
          candidateMOves.add([row + direction, col + 1]);
        }

        break;
      case ChessPieceType.rook:
        var directions = [
          [-1, 0], //up
          [1, 0], //down
          [0, -1], //left
          [0, 1] //right
        ];
        for (var dir in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * dir[0];
            var newcol = col + i * dir[1];
            if (!isInBoard(newRow, newcol)) {
              break;
            }
            if (board[newRow][newcol] != null) {
              if (board[newRow][newcol]!.iswhite != piece.iswhite) {
                candidateMOves.add([newRow, newcol]);
              }
              break;
            }
            candidateMOves.add([newRow, newcol]);
            i++;
          }
        }

        break;
      case ChessPieceType.knight:
        var knightDirections = [
          [-2, -1], //up 2 left 1
          [-2, 1], //up 2 right 1
          [-1, -2], //up 1 left 2
          [-1, 2], //up 1 right 2
          [2, -1], //down 2 left 1
          [2, 1], //down 2 right 1
          [1, -2], //down 1 left 2
          [1, 2] //down 1 right 2
        ];
        for (var move in knightDirections) {
          var newRow = row + move[0];
          var newcol = col + move[1];
          if (!isInBoard(newRow, newcol)) {
            continue;
          }
          if (board[newRow][newcol] != null) {
            if (board[newRow][newcol]!.iswhite != piece.iswhite) {
              candidateMOves.add([newRow, newcol]);
            }
            continue;
          }
          candidateMOves.add([newRow, newcol]);
        }
        break;
      case ChessPieceType.bishop:
      var directions = [
          [-1, -1], 
          [-1, 1],
          [1, -1], 
          [1, 1] 
        ];
        for (var dir in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * dir[0];
            var newcol = col + i * dir[1];
            if (!isInBoard(newRow, newcol)) {
              break;
            }
            if (board[newRow][newcol] != null) {
              if (board[newRow][newcol]!.iswhite != piece.iswhite) {
                candidateMOves.add([newRow, newcol]);
              }
              break;
            }
            candidateMOves.add([newRow, newcol]);
            i++;
          }
        }

        break;
      case ChessPieceType.king:
     var directions = [
          [-1, -1], 
          [-1, 1],
          [1, -1], 
          [1, 1] ,
          [-1, 0], //up
          [1, 0], //down
          [0, -1], //left
          [0, 1] //right
        ];
         for (var dir in directions) {


            var newRow = row + dir[0];
            var newcol = col + dir[1];
            if (!isInBoard(newRow, newcol)) {
              continue;
            }
            if (board[newRow][newcol] != null) {
              if (board[newRow][newcol]!.iswhite != piece.iswhite) {
                candidateMOves.add([newRow, newcol]);
              }
              continue;
            }
            candidateMOves.add([newRow, newcol]);

        }

        break;

      case ChessPieceType.queen:

      var directions = [
          [-1, -1], 
          [-1, 1],
          [1, -1], 
          [1, 1] ,
          [-1, 0], //up
          [1, 0], //down
          [0, -1], //left
          [0, 1] //right
        ];
         for (var dir in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * dir[0];
            var newcol = col + i * dir[1];
            if (!isInBoard(newRow, newcol)) {
              break;
            }
            if (board[newRow][newcol] != null) {
              if (board[newRow][newcol]!.iswhite != piece.iswhite) {
                candidateMOves.add([newRow, newcol]);
              }
              break;
            }
            candidateMOves.add([newRow, newcol]);
            i++;
          }
        }
        break;

      default:
    }
    return candidateMOves;
  }

  //valid mooves

  List<List<int>> validMoves = [];

  void _initialiseBoard() {
    List<List<Chesspiece?>> newboard =
        List.generate(8, (index) => List.generate(8, (index) => null));

//pawn
    for (int i = 0; i < 8; i++) {
      newboard[1][i] = Chesspiece(
          type: ChessPieceType.pawn,
          iswhite: false,
          imagepathw: 'assets/pieces/pawnw.png',
          imagepathb: 'assets/pieces/pawnb.png');
      newboard[6][i] = Chesspiece(
          type: ChessPieceType.pawn,
          iswhite: true,
          imagepathw: 'assets/pieces/pawnw.png',
          imagepathb: 'assets/pieces/pawnb.png');
    }
//rook
    newboard[0][0] = Chesspiece(
        type: ChessPieceType.rook,
        iswhite: false,
        imagepathw: 'assets/pieces/rookw.png',
        imagepathb: 'assets/pieces/rookb.png');
    newboard[0][7] = Chesspiece(
        type: ChessPieceType.rook,
        iswhite: false,
        imagepathw: 'assets/pieces/rookw.png',
        imagepathb: 'assets/pieces/rookb.png');
    newboard[7][7] = Chesspiece(
        type: ChessPieceType.rook,
        iswhite: true,
        imagepathw: 'assets/pieces/rookw.png',
        imagepathb: 'assets/pieces/rookb.png');
    newboard[7][0] = Chesspiece(
        type: ChessPieceType.rook,
        iswhite: true,
        imagepathw: 'assets/pieces/rookw.png',
        imagepathb: 'assets/pieces/rookb.png');

//knight
    newboard[0][1] = Chesspiece(
        type: ChessPieceType.knight,
        iswhite: false,
        imagepathw: 'assets/pieces/knightw.png',
        imagepathb: 'assets/pieces/knightb.png');
    newboard[0][6] = Chesspiece(
        type: ChessPieceType.knight,
        iswhite: false,
        imagepathw: 'assets/pieces/knightw.png',
        imagepathb: 'assets/pieces/knightb.png');
    newboard[7][6] = Chesspiece(
        type: ChessPieceType.knight,
        iswhite: true,
        imagepathw: 'assets/pieces/knightw.png',
        imagepathb: 'assets/pieces/knightb.png');
    newboard[7][1] = Chesspiece(
        type: ChessPieceType.knight,
        iswhite: true,
        imagepathw: 'assets/pieces/knightw.png',
        imagepathb: 'assets/pieces/knightb.png');

//bishop
    newboard[0][2] = Chesspiece(
        type: ChessPieceType.bishop,
        iswhite: false,
        imagepathw: 'assets/pieces/bishopw.png',
        imagepathb: 'assets/pieces/bishopb.png');
    newboard[0][5] = Chesspiece(
        type: ChessPieceType.bishop,
        iswhite: false,
        imagepathw: 'assets/pieces/bishopw.png',
        imagepathb: 'assets/pieces/bishopb.png');
    newboard[7][5] = Chesspiece(
        type: ChessPieceType.bishop,
        iswhite: true,
        imagepathw: 'assets/pieces/bishopw.png',
        imagepathb: 'assets/pieces/bishopb.png');
    newboard[7][2] = Chesspiece(
        type: ChessPieceType.bishop,
        iswhite: true,
        imagepathw: 'assets/pieces/bishopw.png',
        imagepathb: 'assets/pieces/bishopb.png');

//queen
    newboard[0][3] = Chesspiece(
        type: ChessPieceType.queen,
        iswhite: false,
        imagepathw: 'assets/pieces/queenw.png',
        imagepathb: 'assets/pieces/queenb.png');
    newboard[7][4] = Chesspiece(
        type: ChessPieceType.queen,
        iswhite: true,
        imagepathw: 'assets/pieces/queenw.png',
        imagepathb: 'assets/pieces/queenb.png');

//king
    newboard[0][4] = Chesspiece(
        type: ChessPieceType.king,
        iswhite: false,
        imagepathw: 'assets/pieces/kingw.png',
        imagepathb: 'assets/pieces/kingb.png');
    newboard[7][3] = Chesspiece(
        type: ChessPieceType.king,
        iswhite: true,
        imagepathw: 'assets/pieces/kingw.png',
        imagepathb: 'assets/pieces/kingb.png');

    board = newboard;
  }





  void movePiece(int newRow, int newCol) {
    
    if (board[newRow][newCol] != null) {
      Chesspiece capturedPiece = board[newRow][newCol]!;
      if (capturedPiece.iswhite) {
        whitePieceCaptured.add(capturedPiece);
      } else {
        blackPieceCaptured.add(capturedPiece);
      }
    }

    if (selectedPiece!.type == ChessPieceType.king) {
      if (selectedPiece!.iswhite) {
        whiteKing = [newRow, newCol];
      } else {
        blackKing = [newRow, newCol];
      }
    }

    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    checkStatus = isKingCheck(!isWhiteturn);

    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });
if (checkmate(!isWhiteturn)) {
       

showDialog(context: context, builder: (context)=>AlertDialog(title: Text('Checkmate! ${isWhiteturn ? 'White' : 'Black'} wins!'),actions: [TextButton(onPressed: (){
        restart();
      }, child: Text('restart'))],));



      } else if (stalemate(!isWhiteturn)) {
        showEndGameDialog("Ooops It's a draw!");
      }
    
    isWhiteturn = !isWhiteturn;
  }
//reset the game
void restart(){
  Navigator.pop(context);
  _initialiseBoard();
  checkStatus=false;
  whitePieceCaptured.clear();
  blackPieceCaptured.clear();
whiteKing = [7, 3];
blackKing = [0, 4];
selectedRow = -1;
selectedCol = -1;
isWhiteturn = true;
setState(() {
  
});
}



bool isKingCheck(bool isWhiteKing) {
    List<int> kingPosition = isWhiteKing ? whiteKing : blackKing;
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if (board[row][col] == null || board[row][col]!.iswhite == isWhiteKing) {
          continue;
        }
        List<List<int>> opponentMoves = rowValidmoves(row, col, board[row][col]);
        if (opponentMoves.any((move) => move[0] == kingPosition[0] && move[1] == kingPosition[1])) {
          return true;
        }
      }
    }
    return false;
  }

bool simulateMovesSafe(
      Chesspiece piece, int startRow, int startCol, int endRow, int endCol) {
    Chesspiece? originalDestination = board[endRow][endCol];
    List<int> originalKingPosition = piece.iswhite ? List.from(whiteKing) : List.from(blackKing);

    if (piece.type == ChessPieceType.king) {
      if (piece.iswhite) {
        whiteKing = [endRow, endCol];
      } else {
        blackKing = [endRow, endCol];
      }
    }

    board[endRow][endCol] = piece;
    board[startRow][startCol] = null;

    bool kingInCheck = isKingCheck(piece.iswhite);

    board[startRow][startCol] = piece;
    board[endRow][endCol] = originalDestination;

    if (piece.type == ChessPieceType.king) {
      if (piece.iswhite) {
        whiteKing = originalKingPosition;
      } else {
        blackKing = originalKingPosition;
      }
    }

    return !kingInCheck;
  }


//checkmate
bool checkmate(bool isWhiteKing){
if (!isKingCheck(isWhiteKing)) {
  return false;
}
for (var i = 0; i < 8; i++) {
  for (var j = 0; j < 8; j++) {
    if(board[i][j]==null|| board[i][j]!.iswhite!=isWhiteKing){
      continue;
    }
    List<List<int>> pieceValidmoves = realValidmoves(i, j, board[i][j], true);
    if (pieceValidmoves.isNotEmpty) {
      return false;
      
    }
  }
}
return true;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemCount: whitePieceCaptured.length,
                itemBuilder: (BuildContext context, int index)=>Deadpiece(
                  imagepath: whitePieceCaptured[index].imagepathw,
                  iswhite: true,
                ),
              ),
              
            ),
            Text(checkStatus?"check":
            ""),
            Center(
              child: Container(
                width: 368,
                height: 368,
                decoration:
                    BoxDecoration(border: Border.all(color: boardcolor, width: 10)),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                  ),
                  itemCount: 8 * 8,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    int row = index ~/ 8;
                    int col = index % 8;
            
                    bool isSelected = selectedRow == row && selectedCol == col;
            


//king is in check or not
             bool isKingInCheck = checkStatus &&
                      ((isWhiteturn && whiteKing[0] == row && whiteKing[1] == col) ||
                          (!isWhiteturn && blackKing[0] == row && blackKing[1] == col));
                    bool isValidmove = false;
                    for (var position in validMoves) {
                      if (position[0] == row && position[1] == col) {
                        isValidmove = true;
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Square(
                           iswhite: isWhite(index),
                      piece: board[row][col],
                      isSelected: isSelected,
                      isValid: isValidmove,
                      isKingInCheck: isKingInCheck,
                      onTap: () => pieceSelected(row, col)),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemCount: blackPieceCaptured.length,
                itemBuilder: (BuildContext context, int index)=>Deadpiece(
                  imagepath: blackPieceCaptured[index].imagepathb,
                  iswhite: false,
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}