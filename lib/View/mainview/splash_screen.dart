import 'package:e_quranclinic/View/mainview/splash_screen2.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isNavigated = false; // Flag to track whether navigation has occurred

  @override
  void initState() {
    super.initState();
    // Check if navigation hasn't happened yet
    if (!_isNavigated) {
      // Start a timer to navigate after 2 seconds
      Timer(Duration(seconds: 5), () {
        // Navigate to SplashScreen2
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SplashScreen2()),
        );
        // Set flag to true after navigation
        setState(() {
          _isNavigated = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only build the UI if navigation hasn't happened yet
    if (!_isNavigated) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 14.3, 0, 230),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                              width: 474,
                              height: 378,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    'assets/img/logo.png',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // If navigation has already occurred, return an empty container
      // This ensures that SplashScreen is not built again
      return Container();
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}
