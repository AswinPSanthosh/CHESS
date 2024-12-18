import 'package:chess/Screens/widgets.dart';
import 'package:chess/components/Model.dart';
import 'package:chess/components/Gameboard.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: Stack(
  children: [
     Image.asset(
            'assets/other/bg1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
     myAppBar(
            title: 'Your Title',
            onMedalPressed: () {
              
            },
            onSettingsPressed: () {
              
            },
          ),
    
     Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
  
                  ElevatedButton(
                    onPressed: () {
                      // Your action here
                    },
                    style: longButtonStyle(), // Apply the button style
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Play VS Computer',
                          textAlign: TextAlign.center,
                          style: button,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Board()),
                      );
                    },
                    style: longButtonStyle(), // Apply the button style
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Multiplayer',
                          textAlign: TextAlign.center,
                          style: button,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 73,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/other/Bg2.png'), // Replace with the correct asset path
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, -4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
  ],
)
,

    );
  }
}


