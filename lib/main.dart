import 'package:chess/Screens/Home.dart';
import 'package:chess/Screens/Starting.dart';
import 'package:chess/Screens/profile.dart';
import 'package:flutter/material.dart';

void main() {
  
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(title: 'Flutter Demo Home Page'),
    );
  }
}
