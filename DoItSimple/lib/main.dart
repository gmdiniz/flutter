import 'package:flutter/material.dart';
import 'package:mytodolist/screens/splash.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF824670),
          accentColor: Colors.orange
      ),
      home: Splash(),
    );
  }
}

