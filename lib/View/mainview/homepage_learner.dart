import 'package:e_quranclinic/View/widget/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
    return Scaffold(
        appBar: CustomAppBar(
        height: 200, // Set your desired height here
        titleImage: 'assets/img/banner.png', // Set your image path here
        backgroundColor: Colors.teal[100]!, // Set the background color to Colors.teal[100]

    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                        "Upcoming Class",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
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
            ],
          ),
        ),
      ),
    );
  }
}

