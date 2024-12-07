




import 'package:flutter/material.dart';

isWhite(int index){
int x = index~/8;
int y = index%8;
bool iswhite = (x+y)%2 ==0;
return iswhite;
}

bool isInBoard(int row , int col){
  return row>= 0 && row <8 && col>= 0 && col <8;


}

//text style 
TextStyle top_text = TextStyle(
color: Colors.white,
fontSize: 30,
fontFamily: 'Roboto',
fontWeight: FontWeight.w700,
letterSpacing: 0.30,
);
TextStyle button = TextStyle(
color: Colors.white,
fontSize: 20,
fontFamily: 'Roboto',
fontWeight: FontWeight.w700,

);