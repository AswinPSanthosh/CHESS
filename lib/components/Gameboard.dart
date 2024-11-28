import 'package:chess/Model.dart';
import 'package:chess/Square.dart';
import 'package:chess/components/chesspiece.dart';
import 'package:chess/components/colors.dart';
import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  const Board({super.key});
  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Chesspiece? selectedPiece;
//no row selected
  int selectedRow = -1;

//no column selected
  int selectedCol = -1;

  void initState() {
    super.initState();
    _initialiseBoard();
  }

  void pieceSelected(int row, int col) {
    setState(() {
      if (board[row][col] != null) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }
      validMoves = rowValidmoves(selectedRow, selectedCol, selectedPiece);
    });
    // calculate valid moves for selected piece
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
         
            var newRow = row +  dir[0];
            var newcol = col +  dir[1];
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

//condition checking , revome afterwards
   
        newboard[3][2] = Chesspiece(
        type: ChessPieceType.king,
        iswhite: false,
        imagepathw: 'assets/pieces/kingw.png',
        imagepathb: 'assets/pieces/kingb.png');

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

  late List<List<Chesspiece?>> board;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                      onTap: () => pieceSelected(row, col)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
