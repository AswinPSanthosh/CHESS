// ignore_for_file: public_member_api_docs, sort_constructors_first
enum ChessPieceType { pawn , rook , bishop , queen, king , knight}


class Chesspiece {
  final ChessPieceType type;
  final bool iswhite;
  final String imagepathw;
  final String imagepathb;

  Chesspiece({
    required this.type,
    required this.iswhite,
    required this.imagepathw,
    required this.imagepathb,

  });
  
}
