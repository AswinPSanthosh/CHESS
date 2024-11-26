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



  void initState() {
    super.initState();
    _initialiseBoard();
    
  }
  void _initialiseBoard(){
List<List<Chesspiece?>>newboard = List.generate(8, (index)=>List.generate(8, (index)=> null));



//pawn
for (int i =0 ; i<8; i++)
{
  newboard[1][i]=Chesspiece(type: ChessPieceType.pawn, iswhite: false,  imagepathw: 'assets/pieces/pawnw.png', imagepathb: 'assets/pieces/pawnb.png');
  newboard[6][i]=Chesspiece(type: ChessPieceType.pawn, iswhite: true,  imagepathw: 'assets/pieces/pawnw.png', imagepathb: 'assets/pieces/pawnb.png');

}
//rook
 newboard[0][0]=Chesspiece(type: ChessPieceType.rook, iswhite: false,  imagepathw: 'assets/pieces/rookw.png', imagepathb: 'assets/pieces/rookb.png');
  newboard[0][7]=Chesspiece(type: ChessPieceType.rook, iswhite: false,  imagepathw: 'assets/pieces/rookw.png', imagepathb: 'assets/pieces/rookb.png'); 
  newboard[7][7]=Chesspiece(type: ChessPieceType.rook, iswhite: true,  imagepathw: 'assets/pieces/rookw.png', imagepathb: 'assets/pieces/rookb.png');
   newboard[7][0]=Chesspiece(type: ChessPieceType.rook, iswhite: true,  imagepathw: 'assets/pieces/rookw.png', imagepathb: 'assets/pieces/rookb.png');

//knight
 newboard[0][1]=Chesspiece(type: ChessPieceType.knight, iswhite: false,  imagepathw: 'assets/pieces/knightw.png', imagepathb: 'assets/pieces/knightb.png');
  newboard[0][6]=Chesspiece(type: ChessPieceType.knight, iswhite: false,  imagepathw: 'assets/pieces/knightw.png', imagepathb: 'assets/pieces/knightb.png'); 
  newboard[7][6]=Chesspiece(type: ChessPieceType.knight, iswhite: true,  imagepathw: 'assets/pieces/knightw.png', imagepathb: 'assets/pieces/knightb.png');
   newboard[7][1]=Chesspiece(type: ChessPieceType.knight, iswhite: true,  imagepathw: 'assets/pieces/knightw.png', imagepathb: 'assets/pieces/knightb.png');

//bishop
 newboard[0][2]=Chesspiece(type: ChessPieceType.bishop, iswhite: false,  imagepathw: 'assets/pieces/bishopw.png', imagepathb: 'assets/pieces/bishopb.png');
  newboard[0][5]=Chesspiece(type: ChessPieceType.bishop, iswhite: false,  imagepathw: 'assets/pieces/bishopw.png', imagepathb: 'assets/pieces/bishopb.png'); 
  newboard[7][5]=Chesspiece(type: ChessPieceType.bishop, iswhite: true,  imagepathw: 'assets/pieces/bishopw.png', imagepathb: 'assets/pieces/bishopb.png');
   newboard[7][2]=Chesspiece(type: ChessPieceType.bishop, iswhite: true,  imagepathw: 'assets/pieces/bishopw.png', imagepathb: 'assets/pieces/bishopb.png');

//queen
newboard[0][3]=Chesspiece(type: ChessPieceType.queen, iswhite: false,  imagepathw: 'assets/pieces/queenw.png', imagepathb: 'assets/pieces/queenb.png'); 
  newboard[7][4]=Chesspiece(type: ChessPieceType.queen, iswhite: true,  imagepathw: 'assets/pieces/queenw.png', imagepathb: 'assets/pieces/queenb.png');


//king
newboard[0][4]=Chesspiece(type: ChessPieceType.king, iswhite: false,  imagepathw: 'assets/pieces/kingw.png', imagepathb: 'assets/pieces/kingb.png'); 
  newboard[7][3]=Chesspiece(type: ChessPieceType.king, iswhite: true,  imagepathw: 'assets/pieces/kingw.png', imagepathb: 'assets/pieces/kingb.png');


board = newboard;

}





late List<List<Chesspiece?>>board;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 368,
          height: 368,
            decoration: BoxDecoration(border: Border.all(
              color: boardcolor,
              width: 10
            )),
            child: GridView.builder(
              
              
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                
                crossAxisCount: 8,
              ),
              itemCount: 8*8,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {


                int row = index ~/8;
                int col = index%8;
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Square(iswhite: isWhite(index),
                  piece: board[row][col],),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}



