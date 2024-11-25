

import 'package:chess/components/chesspiece.dart';
import 'package:chess/components/colors.dart';
import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  const Square({super.key, required this.iswhite,required this.piece});
final bool iswhite;
final Chesspiece? piece;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: iswhite?squireWhite:squireBlack,
      child: piece!= null?(Image.asset(piececolor()) 
      ): null,
      
    );
  }

piececolor(){
  return piece!.iswhite? piece!.imagepathw: piece!.imagepathb;
  }
}

