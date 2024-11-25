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
   Chesspiece mypawn = Chesspiece(type: ChessPieceType.pawn, iswhite: true, imagepathw: 'assets/pieces/pawnw.png', imagepathb: 'assets/pieces/pawnb.png');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 368,
          height: 368,
            decoration: BoxDecoration(border: Border.all(
              color: board,
              width: 10
            )),
            child: GridView.builder(
              
              
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                
                crossAxisCount: 8,
              ),
              itemCount: 8*8,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Square(iswhite: isWhite(index),
                  piece: mypawn,),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}



