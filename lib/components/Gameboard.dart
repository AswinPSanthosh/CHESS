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
        break;
      case ChessPieceType.bishop:
        break;
      case ChessPieceType.king:
        break;
      case ChessPieceType.knight:
        break;
      case ChessPieceType.queen:
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
    newboard[2][2] = Chesspiece(
        type: ChessPieceType.rook,
        iswhite: true,
        imagepathw: 'assets/pieces/rookw.png',
        imagepathb: 'assets/pieces/rookb.png');

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
