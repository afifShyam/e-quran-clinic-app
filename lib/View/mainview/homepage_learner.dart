import 'package:e_quranclinic/View/tutorsession/view_tutor.dart';
import 'package:e_quranclinic/View/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'homepage_tutor.dart';


class HomePageLearner extends StatefulWidget {
  HomePageLearner();

  @override
  State<HomePageLearner> createState() => _HomePageLearnerState();
}

class _HomePageLearnerState extends State<HomePageLearner> {
  late String phone; // To store the retrieved phone number
  late String name;
  late int id;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                Center(
                  child: Container(
                    height: 1000,
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
                                "Upcoming class.",
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
                        builder: (context) => ViewVerifiedTutor(),
                      ),
                    );
                  },
                  child: Text(
                    'Book Slot',
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
        ),
      ),
    );
  }
}
