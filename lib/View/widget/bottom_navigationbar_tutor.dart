import 'package:e_quranclinic/View/mainview/homepage_tutor.dart';
import 'package:flutter/material.dart';
import '../tutorsession/view_slot.dart';

class TutorNavigationBarWidget extends StatefulWidget {
  const TutorNavigationBarWidget({super.key, required void Function(int index) onItemTapped, required int selectedIndex});

  @override
  _TutorNavigationBarWidgetState createState() =>
      _TutorNavigationBarWidgetState();
}

class _TutorNavigationBarWidgetState extends State<TutorNavigationBarWidget> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePageTutor(),
    ViewSlot(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_calendar_outlined),
            label: 'Manage Booking',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
