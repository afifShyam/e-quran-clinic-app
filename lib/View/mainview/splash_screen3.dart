import 'package:e_quranclinic/View/authentication/register_tutor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_quranclinic/View/authentication/login_learner.dart';
import 'package:e_quranclinic/View/authentication/login_tutor.dart';

import '../authentication/register_learner.dart';

class SplashScreen3 extends StatefulWidget {
  @override
  _SplashScreen3State createState() => _SplashScreen3State();
}

class _SplashScreen3State extends State<SplashScreen3> {
  @override
  void initState() {
    super.initState();
    // Start a timer to navigate after 2 seconds
    // Timer(Duration(seconds: 2), () {
    //   // Navigate to Login
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => LoginScreen()),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      width: 475,
                      height: 464,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/img/splashscreen3.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Let\'s start learning!',
                            style: GoogleFonts.getFont(
                              'Rubik',
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              height: 1.3,
                              letterSpacing: -0.5,
                              color: Color(0xFF3C3A36),
                            ),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE3562A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 19),
                              minimumSize: Size(167, 0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginTutorScreen()),
                              );
                            },
                            child: Text(
                              'I am a tutor',
                              style: GoogleFonts.getFont(
                                'Rubik',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE3562A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 19),
                          minimumSize: Size(167, 0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => LoginLearnerScreen()),
                          );
                        },
                        child: Text(
                          'I am a learner',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            'Rubik',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Don’t have an account yet? ',
                            style: GoogleFonts.getFont(
                              'Rubik',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF78746D),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                title: const Text(
                                  'Please select your role',
                                  style: TextStyle(color: Colors.black),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterTutorScreen()),
                                      );
                                    },
                                    child: const Text(
                                      'Tutor',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterLearnerScreen()),
                                      );
                                    },
                                    child: const Text(
                                      'Learner',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ),
                                ],
                                elevation: 24.0,
                                shadowColor: Colors.orange.withOpacity(0.5),
                              ),
                            ),
                            child: Text(
                              'Register now!',
                              style: GoogleFonts.getFont(
                                'Rubik',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Color(0xFFE3562A),
                              ),
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
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: SplashScreen3(),
//   ));
// }
