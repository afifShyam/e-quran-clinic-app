import 'package:flutter/material.dart';
import 'package:e_quranclinic/View/mainview/login.dart'; // Import Login.dart
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class SplashScreen2 extends StatefulWidget {
  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  bool _isNavigated = false; // Flag to track whether navigation has occurred

  @override
  void initState() {
    super.initState();
    // Check if navigation hasn't happened yet
    if (!_isNavigated) {
      // Start a timer to navigate after 2 seconds
      Timer(Duration(seconds: 2), () {
        // Navigate to Login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
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
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                                  width: 375,
                                  height: 264,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                          'assets/img/splashscreen1.png',
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      width: 375,
                                      height: 264,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(34.7, 0, 36.7, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                        child: Text(
                                          'Learn anytime and anywhere',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.getFont(
                                            'Rubik',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 24,
                                            height: 1.3,
                                            letterSpacing: -0.5,
                                            color: Color(0xFF3C3A36),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Quarantine is the perfect time to spend your day learning something new, from anywhere!',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.getFont(
                                          'Rubik',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          height: 1.5,
                                          color: Color(0xFF78746D),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
  }
}

void main() {
  runApp(MaterialApp(
    home: SplashScreen2(),
  ));
}
