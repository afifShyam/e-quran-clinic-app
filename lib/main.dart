import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_quranclinic/View/authentication/login_learner.dart';
import 'package:e_quranclinic/View/mainview/homepage_tutor.dart';
import 'package:e_quranclinic/View/mainview/splash_screen.dart';
import 'package:e_quranclinic/View/tutorsession/view_slot.dart';
import 'package:e_quranclinic/View/widget/bottom_navigationbar_tutor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.teal,
        // textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: BackgroundContainer(
        child: NavigationManager(),
      ),
    );
  }
}

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
  @override
  _NavigationManagerState createState() => _NavigationManagerState();
}

class _NavigationManagerState extends State<NavigationManager> {
  int _selectedIndex = 0;
  bool _showSplash = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
        _showSplash;
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return SplashScreen(); // Show SplashScreen initially
    }

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
