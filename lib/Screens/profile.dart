import 'package:chess/components/Model.dart';
import 'package:chess/components/colors.dart';
import 'package:chess/Screens/widgets.dart';
import 'package:flutter/material.dart';









class Profile extends StatelessWidget {
  const Profile({Key? key, required this.title}) : super(key: key);

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
      child: Container(
        width: 350,
        height: 450,
        decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/other/Bg2.png'), // Background image
        fit: BoxFit.cover, // Ensures the image covers the entire container
      ),
      border: Border.all(
        color: darkborder, // Border color
        width: 15, // Border thickness
      ),
      borderRadius: BorderRadius.circular(20), // Optional: rounded corners for a smoother look
        ),
        child: Column(
      children: [
                  const SizedBox(height: 30),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blue[200],
          child: const CircleAvatar(
            radius: 45,
            backgroundImage:  AssetImage('assets/Avatar/Guy 1.png'),
          ),
        ), const Divider(
        color: Colors.white,  
        thickness: 2,         
        indent: 20,           
        endIndent: 20,       
      ),
        
        Column(
          children: [
             const SizedBox(height: 20),
            const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
             const SizedBox(height: 10),
            const Row(
              children: [
                SizedBox(width: 30,),
                Column(
                  children:[
                     Text(
                      'Games:',
                      style: TextStyle(
                        
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      
                    ), SizedBox(height: 20),
                    Text(
                  'Won: ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ), 
                SizedBox(height: 20),
                Text(
                  'Lost: ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  ],
                ),
                SizedBox(width: 130),
                SizedBox(height: 20),
                 
                Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 20),
                 
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ), SizedBox(height: 20),
                 
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  ],
                  
                ),
                
              ],
            ),
            SizedBox(height: 10,),
      ElevatedButton(
  onPressed: () {
    // Handle button press here
    print('Button Pressed');
  },
  style: customButtonStyle(),
  child: Text(
    'LOGOUT',
    textAlign: TextAlign.center,
    style: button
  ),
)
        
          ],
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

