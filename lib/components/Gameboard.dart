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
  // No row selected
  int selectedRow = -1;

  // No column selected
  int selectedCol = -1;

  // Turn  
  bool isWhiteturn = true;

  // Captured pieces
  List<Chesspiece> blackPieceCaptured = [];
  List<Chesspiece> whitePieceCaptured = [];

  // King 
  List<int> whiteKing = [7, 4];
  List<int> blackKing = [0, 4];
  bool checkStatus = false;

  // List to track attacking pieces (for further enhancements)
  List<List<int>> attackingMoves = [];

  // List of invalid king moves when in check
  List<List<int>> invalidKingMoves = [];




  @override
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
        }
      }
      else if (board[row][col] != null && board[row][col]!.iswhite == selectedPiece!.iswhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }
      else if (selectedPiece != null && validMoves.any((element) => element[0] == row && element[1] == col)) {
        movePiece(row, col);
      }
      validMoves = rowValidmoves(selectedRow, selectedCol, selectedPiece);
    });
    // Calculate valid moves for selected piece
  }

  // Calculate row valid moves
  List<List<int>> rowValidmoves(int row, int col, Chesspiece? piece) {
    List<List<int>> candidateMOves = [];

    int direction = piece!.iswhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
        // Going one step up
        if (isInBoard(row + direction, col) && board[row + direction][col] == null) {
          candidateMOves.add([row + direction, col]);
        }

        // Going 2 moves
        if ((row == 1 && !piece.iswhite) || (row == 6 && piece.iswhite)) {
          if (isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMOves.add([row + 2 * direction, col]);
          }
        }

        // Kill diagonally to the left
        if (isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.iswhite != piece.iswhite) {
          candidateMOves.add([row + direction, col - 1]);
        }

        // Kill diagonally to the right
        if (isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.iswhite != piece.iswhite) {
          candidateMOves.add([row + direction, col + 1]);
        }

        break;
      case ChessPieceType.rook:
        var directions = [
          [-1, 0], // Up
          [1, 0],  // Down
          [0, -1], // Left
          [0, 1]   // Right
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
          [-2, -1], // Up 2 Left 1
          [-2, 1],  // Up 2 Right 1
          [-1, -2], // Up 1 Left 2
          [-1, 2],  // Up 1 Right 2
          [2, -1],  // Down 2 Left 1
          [2, 1],   // Down 2 Right 1
          [1, -2],  // Down 1 Left 2
          [1, 2]    // Down 1 Right 2
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
          [1, 1],
          [-1, 0], // Up
          [1, 0],  // Down
          [0, -1], // Left
          [0, 1]   // Right
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
          [1, 1],
          [-1, 0], // Up
          [1, 0],  // Down
          [0, -1], // Left
          [0, 1]   // Right
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

  // Valid moves
  List<List<int>> validMoves = [];

  void _initialiseBoard() {
    List<List<Chesspiece?>> newboard =
        List.generate(8, (index) => List.generate(8, (index) => null));

    // Initialize pawns
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

    // Initialize rooks
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

    // Initialize knights
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

    // Initialize bishops
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

    // Initialize queens
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

    // Initialize kings
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

  late List<List<Chesspiece?>> board;

  void movePiece(int newRow, int newcol) {
    // Adding captured piece to list
    if (board[newRow][newcol] != null) {
      var capturedPiece = board[newRow][newcol];
      if (capturedPiece!.iswhite) {
        whitePieceCaptured.add(capturedPiece);
      }
      else {
        blackPieceCaptured.add(capturedPiece);
      }
    }

    // Save the current board state (in case we need to revert)
    Chesspiece? originalDestination = board[newRow][newcol];
    Chesspiece? movingPiece = selectedPiece;

    // Move the piece
    board[newRow][newcol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    // Update king position if the king moved
    if (movingPiece!.type == ChessPieceType.king) {
      if (movingPiece.iswhite) {
        whiteKing = [newRow, newcol];
      } else {
        blackKing = [newRow, newcol];
      }
    }

    // Check if the move puts the opponent's king in check
    bool opponentInCheck = isKingInCheck(!isWhiteturn);

    // If moving player's king is now in check, revert the move
    bool selfInCheck = isKingInCheck(movingPiece.iswhite);

    if (selfInCheck) {
      // Revert the move
      board[selectedRow][selectedCol] = selectedPiece;
      board[newRow][newcol] = originalDestination;

      // Revert king position if needed
      if (movingPiece.type == ChessPieceType.king) {
        if (movingPiece.iswhite) {
          whiteKing = [selectedRow, selectedCol];
        } else {
          blackKing = [selectedRow, selectedCol];
        }
      }

      // Notify the user
      print("Invalid move: Your king would be in check!");
    } else {
      // Move is valid, update check status
      checkStatus = opponentInCheck;

      if (checkStatus) {
        // Identify invalid king moves
        invalidKingMoves = getInvalidKingMoves(!isWhiteturn);
      } else {
        invalidKingMoves = [];
      }

      // Change turn
      isWhiteturn = !isWhiteturn;
    }

    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });
  }

  bool isKingCheck = false;

  bool isKingInCheck(bool isWhiteKing) {
    // Determine the king's position
    List<int> kingPosition = isWhiteKing ? whiteKing : blackKing;

    // Loop through the board to find all opponent's pieces
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if (board[row][col] == null || board[row][col]!.iswhite == isWhiteKing) {
          continue;
        }
        List<List<int>> pieceValidMoves = rowValidmoves(row, col, board[row][col]);
        if (pieceValidMoves.any((move) => move[0] == kingPosition[0] && move[1] == kingPosition[1])) {
          return true; // King is in check
        }
      }
    }
    return false; // King is safe
  }

  // Function to identify invalid king moves when in check
  List<List<int>> getInvalidKingMoves(bool isWhiteKing) {
    List<List<int>> invalidMoves = [];
    List<int> kingPosition = isWhiteKing ? whiteKing : blackKing;

    // Get all possible moves for the king
    Chesspiece? kingPiece = board[kingPosition[0]][kingPosition[1]];
    if (kingPiece == null || kingPiece.type != ChessPieceType.king) {
      return invalidMoves; // No king found, should not happen
    }

    List<List<int>> allKingMoves = rowValidmoves(kingPosition[0], kingPosition[1], kingPiece);

    for (var move in allKingMoves) {
      // Simulate the move
      Chesspiece? originalDestination = board[move[0]][move[1]];
      board[move[0]][move[1]] = kingPiece;
      board[kingPosition[0]][kingPosition[1]] = null;

      // Temporarily update king's position
      List<int> tempKingPos = [move[0], move[1]];
      bool isStillInCheck = false;

      // Check if the king is still in check after the move
      for (int row = 0; row < 8; row++) {
        for (int col = 0; col < 8; col++) {
          if (board[row][col] == null || board[row][col]!.iswhite == isWhiteKing) {
            continue;
          }
          List<List<int>> opponentMoves = rowValidmoves(row, col, board[row][col]);
          if (opponentMoves.any((opMove) => opMove[0] == tempKingPos[0] && opMove[1] == tempKingPos[1])) {
            isStillInCheck = true;
            break;
          }
        }
        if (isStillInCheck) break;
      }

      // Revert the simulated move
      board[kingPosition[0]][kingPosition[1]] = kingPiece;
      board[move[0]][move[1]] = originalDestination;

      if (isStillInCheck) {
        invalidMoves.add(move);
      }
    }

    return invalidMoves;
  }

  // Helper function to check if a position is within the board
  bool isInBoard(int row, int col) {
    return row >= 0 && row < 8 && col >= 0 && col < 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Captured White Pieces
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemCount: whitePieceCaptured.length,
                itemBuilder: (BuildContext context, int index) => Deadpiece(
                  imagepath: whitePieceCaptured[index].imagepathw,
                  iswhite: true,
                ),
              ),
            ),
            // Display "Check" text
            Text(
              checkStatus ? "Check!" : "",
              style: TextStyle(
                fontSize: 24,
                color: checkStatus ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Chess Board
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

                    bool isValidmove = validMoves.any((element) => element[0] == row && element[1] == col);

                    // Determine if this square is the king's tile in check
                    bool isKingTile = false;
                    bool isKingInCheckFlag = false;

                    if (checkStatus) {
                      if ((isWhiteturn && row == whiteKing[0] && col == whiteKing[1]) ||
                          (!isWhiteturn && row == blackKing[0] && col == blackKing[1])) {
                        isKingTile = true;
                        isKingInCheckFlag = true;
                      }
                    }

                    // Determine if this square is an invalid king move
                    bool isInvalidKingMove = invalidKingMoves.any((move) => move[0] == row && move[1] == col);

                    return Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Square(
                        iswhite: isWhite(index),
                        piece: board[row][col],
                        isSelected: isSelected,
                        isValid: isValidmove,
                        onTap: () => pieceSelected(row, col),
                        isKingInCheck: isKingInCheckFlag,
                        isInvalidKingMove: isInvalidKingMove,
                        isKingTile: isKingTile,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Captured Black Pieces
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemCount: blackPieceCaptured.length,
                itemBuilder: (BuildContext context, int index) => Deadpiece(
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

  // Helper function to determine square color
  bool isWhite(int index) {
    int row = index ~/ 8;
    int col = index % 8;
    return (row + col) % 2 == 0;
  }
}
