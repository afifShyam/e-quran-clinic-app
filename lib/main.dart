import 'package:e_quranclinic/View/authentication/register_learner.dart';
import 'package:e_quranclinic/View/authentication/register_tutor.dart';
import 'package:e_quranclinic/View/mainview/homepage_learner.dart';
import 'package:flutter/material.dart';
import 'View/authentication/login_learner.dart';
import '/View/mainview/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'View/mainview/splash_screen3.dart';
import 'View/widget/custom_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,


      ),
      home: SplashScreen(),
     // home: RegisterTutorScreen(),
      //home: HomePage(phone: '', name: '', id: 0,),

    );
  }

}


