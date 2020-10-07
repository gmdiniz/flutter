import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:mytodolist/sidebar/sidebar_layout.dart';

class Splash extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.black,
      image: Image.asset("imagens/check.gif"),
      photoSize: 150.0,
      navigateAfterSeconds: SideBarLayout(),
    );
  }
}
