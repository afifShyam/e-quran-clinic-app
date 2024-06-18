import 'dart:developer';

import 'package:e_quranclinic/View/mainview/splash_screen2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_quranclinic/View/authentication/login_learner.dart';
import 'package:e_quranclinic/View/mainview/homepage_tutor.dart';
import 'package:e_quranclinic/View/mainview/splash_screen.dart';
import 'package:e_quranclinic/View/tutorsession/view_slot.dart';
import 'package:e_quranclinic/View/widget/bottom_navigationbar_tutor.dart';

import 'View/authentication/login_tutor.dart';
import 'View/mainview/splash_screen3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // primarySwatch: Colors.teal,
          // textTheme: GoogleFonts.poppinsTextTheme(),
          ),
      // home: BackgroundContainer(
      //   child: NavigationManager(),
      // ),
      initialRoute: '/splash',
      onGenerateRoute: (initialRoute) {
        log('what is : $initialRoute');
        switch (initialRoute.name) {
          // case '/':
          //   return MaterialPageRoute(
          //     builder: (context) => BackgroundContainer(
          //       child: NavigationManager(),
          //     ),
          //   );
          case '/splash':
            return MaterialPageRoute(
              builder: (context) => SplashScreen(),
            );
          case '/splash1':
            return MaterialPageRoute(
              builder: (context) => SplashScreen2(),
            );
          case '/splash2':
            return MaterialPageRoute(
              builder: (context) => SplashScreen3(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${initialRoute.name}'),
                ),
              ),
            );
        }
      },
    );
  }
}

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/backgroundimage.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class NavigationManager extends StatefulWidget {
  const NavigationManager({super.key});

  @override
  State<NavigationManager> createState() => _NavigationManagerState();
}

class _NavigationManagerState extends State<NavigationManager> {
  int _selectedIndex = 0;
  // bool _showSplash = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // _showSplash;
  }

  @override
  Widget build(BuildContext context) {
    // if (_showSplash) {
    //   return SplashScreen(); // Show SplashScreen initially
    // }

    final List<Widget> _pages = <Widget>[
      HomePageTutor(),
      ViewSlot(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          _pages.elementAt(_selectedIndex),
          Align(
            alignment: Alignment.bottomCenter,
            child: TutorNavigationBarWidget(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
