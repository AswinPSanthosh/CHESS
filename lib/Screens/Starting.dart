import 'package:chess/Model.dart';
import 'package:chess/components/colors.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
              child: Image.asset(
                'assets/other/Start.png', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
     Center(
       child: ElevatedButton(
  onPressed: () {
    // Handle button press here
    print('Button Pressed');
  },
  style: ElevatedButton.styleFrom(
    fixedSize: Size(244, 55), // Set button size
    backgroundColor: button_color, // Background color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50), // Rounded corners
    ),
    padding: EdgeInsets.all(10), // Add padding inside the button
  ),
  child: Text(
    'LOGIN',
    textAlign: TextAlign.center,
    style: top_text
  ),
)

     )
      ]);
  }
}