// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:chess/components/chesspiece.dart';
import 'package:chess/components/colors.dart';

class Square extends StatelessWidget {
  const Square({
    Key? key,
    required this.iswhite,
    required this.piece,
    required this.isSelected,
    required this.isValid,
    required this.onTap,
  }) : super(key: key);
  final bool iswhite;
  final Chesspiece? piece;
  final bool isSelected;
  final bool isValid;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Color? squarecolor;
    if (isSelected) {
      squarecolor = Colors.green;
    } else if (isValid) {
      squarecolor = const Color.fromARGB(255, 2, 80, 4);
    } else {
      squarecolor = iswhite ? squireWhite : squireBlack;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squarecolor,
        child: piece != null ? (Image.asset(piececolor())) : null,
      ),
    );
  }

  piececolor() {
    return piece!.iswhite ? piece!.imagepathw : piece!.imagepathb;
  }
}
