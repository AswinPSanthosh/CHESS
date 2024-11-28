// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Deadpiece extends StatelessWidget {
  final bool iswhite;
  final String imagepath;

  const Deadpiece({
    Key? key,
    required this.iswhite,
    required this.imagepath,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagepath);
  }


}

