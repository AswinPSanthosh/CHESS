import 'package:chess/components/colors.dart';
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

ButtonStyle customButtonStyle() {
  return ElevatedButton.styleFrom(
    fixedSize: const Size(150, 40), // Set button size
    backgroundColor: const Color(0xFF63462C), // Background color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50), // Rounded corners
    ),
    padding: const EdgeInsets.all(10), // Internal padding
  );
}


//button
ButtonStyle longButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: button_color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13),
    ),
    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
    shadowColor: Color(0x3F000000), 
     minimumSize: Size(305, 56), 
    elevation: 4, // Shadow elevation
  );
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