import 'package:e_quranclinic/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../tutorsession/view_slot.dart';
import '../widget/bottom_navigationbar_tutor.dart';

Future<String?> getNameFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('name'); // Assuming the key for the name is 'name'
}

class HomePageTutor extends StatefulWidget {

  @override
  State<HomePageTutor> createState() => _HomePageTutorState();
}

class _HomePageTutorState extends State<HomePageTutor> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/backgroundimage.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50), // Adjust the height as needed
              Image.asset(
                'assets/img/banner.png',
                fit: BoxFit.contain,
                height: 100,
              ),
              SizedBox(height: 8.0), // Add space between the image and text
              FutureBuilder<String?>(
                future: getNameFromPrefs(), // Fetch the name asynchronously
                builder: (context, snapshot) {
                  String name = snapshot.data ?? 'User'; // Default to 'User' if name not found
                  return Text(
                    "$name ٱلسَّلَامُ عَلَيْكُمْ، ", // Display the retrieved name
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0), // Add space below the text
              Center(
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.symmetric(vertical: 1.0),
                  decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add your onTap functionality here
                        },
                        child: Column(
                          children: [
                            Text(
                              "No upcoming class.",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                textStyle: const TextStyle(fontSize: 22, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add space below the text
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
                      builder: (context) => ViewSlot(),
                    ),
                  );
                },
                child: Text(
                  'Book Slot',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 400.0), // Add space below the button
             // TutorNavigationBarWidget(
             //    onItemTapped: (index) {
             //      // Handle navigation based on the index
             //    },
             //  ),
            ],
          ),
        ),
      ),
    );
  }
}

