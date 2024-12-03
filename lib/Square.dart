import 'package:flutter/material.dart';

import 'package:chess/components/chesspiece.dart';
import 'package:chess/components/colors.dart';

class Square extends StatelessWidget {
final bool iswhite;
  final Chesspiece? piece;
  final bool isSelected;
  final bool isValid;
  final bool isKingInCheck;
  final VoidCallback onTap;

  const Square({
    Key? key,
    required this.iswhite,
    this.piece,
    required this.isSelected,
    required this.isValid,
    required this.isKingInCheck,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? squarecolor;

    // Highlight the king's square if the king is in check
    
    if (isKingInCheck) {
      squarecolor = capturecolor;
      }
    else if (isSelected) {
      squarecolor = selectcolor;
    }
    // Highlight valid capture squares in red
    else if (isValid && piece != null) {
      squarecolor = capturecolor;
    }
    // Highlight valid move squares
    else if (isValid) {
      squarecolor = validmovecolor;
    }
    // Default square colors
    else {
      squarecolor = iswhite ? squireWhite : squireBlack;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squarecolor,
        child: piece != null ? Image.asset(piececolor()) : null,
      ),
    );
  }

  piececolor() {
    return piece!.iswhite ? piece!.imagepathw : piece!.imagepathb;
  }
}
