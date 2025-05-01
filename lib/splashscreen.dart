import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFA28607A), // Dark Blue Background
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Adjust the value for more/less rounding
          child: Image.asset(
            'assets/OutFitMatcher_1.jpg',
            width: 150,
            height: 126,
            fit: BoxFit.cover, // Ensures the image fills the space properly
          ),
        ),
      ),
    );
  }
}
