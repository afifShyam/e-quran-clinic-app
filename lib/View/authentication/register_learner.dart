import 'package:e_quranclinic/View/mainview/splash_screen3.dart';
import 'package:e_quranclinic/View/widget/custom_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import '../../Repo/Authentication/learner_repo.dart';
import 'login_learner.dart';

void main() {
  runApp(const MaterialApp(
    home: RegisterLearnerScreen(),
  ));
}

class RegisterLearnerScreen extends StatefulWidget {
  const RegisterLearnerScreen({Key? key}) : super(key: key);

  @override
  _RegisterLearnerScreenState createState() => _RegisterLearnerScreenState();
}

class _RegisterLearnerScreenState extends State<RegisterLearnerScreen> {
  bool _obscureText = true;
  bool _isPasswordEightCharacters = false;
  bool _havePasswordConstraints = false;
  bool _passwordTotalConstraints = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController proficiencyLevelController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  onPasswordChanged(String password) {
    final numericRegex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    setState(() {
      _isPasswordEightCharacters = password.length >= 8;
      _havePasswordConstraints = numericRegex.hasMatch(password);
      _passwordTotalConstraints =
          _isPasswordEightCharacters && _havePasswordConstraints;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
      padding: const EdgeInsets.fromLTRB(10, 60, 16, 100),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen3()),
                    );
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      'assets/vectors/back_icon.svg',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/img/logo.png',
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Registration',
                    style: GoogleFonts.getFont(
                      'Rubik',
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      height: 1.3,
                      letterSpacing: -0.5,
                      color: const Color(0xFF3C3A36),
                    ),
                  ),
                  Text(
                    'Create your profile',
                    style: GoogleFonts.getFont(
                      'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: const Color(0xFF78746D),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 21),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFBEBAB3)),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Name',
                    hintStyle: GoogleFonts.getFont(
                      'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: const Color(0xFF78746D),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 21),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFBEBAB3)),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: genderController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Gender',
                    hintStyle: GoogleFonts.getFont(
                      'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: const Color(0xFF78746D),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 21),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFBEBAB3)),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Age',
                    hintStyle: GoogleFonts.getFont(
                      'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: const Color(0xFF78746D),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 21),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFBEBAB3)),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: proficiencyLevelController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Proficiency level',
                    hintStyle: GoogleFonts.getFont(
                      'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: const Color(0xFF78746D),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 21),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFBEBAB3)),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    hintStyle: GoogleFonts.getFont(
                      'Rubik',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: const Color(0xFF78746D),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFBEBAB3)),
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscureText,
                        onChanged: onPasswordChanged,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: GoogleFonts.getFont(
                            'Rubik',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.5,
                            color: const Color(0xFF78746D),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: const Color(0xFF78746D),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomCenter,
              // Adjust alignment as needed
              child: ElevatedButton(
                onPressed: () async {
                  // Call the login function and await its result
                  int result = await registerLearner(nameController.text,genderController.text,
                      int.parse(ageController.text), phoneController.text,
                      passwordController.text, proficiencyLevelController.text);
                  // Handle the result if needed
                  // For example, you can check the result and show a toast message accordingly
                  if (result == 1) {
                    Fluttertoast.showToast(msg: 'Successfully Registered');
                    print('BOLEHHHHHHHHHHH');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  LoginLearnerScreen(),
                        ));
                  } else {
                    // Login failed
                    // Show an error message
                    Fluttertoast.showToast(msg: 'Registration failed');
                  }
                },

                child: Container(
                  width: 100,
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 19),
                  alignment: Alignment.center,
                  child: Text(
                    'Register',
                    style: GoogleFonts.getFont(
                      'Rubik',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.1,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              // Adjust alignment as needed
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginLearnerScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    'Log in',
                    style: GoogleFonts.getFont(
                      'Rubik',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.1,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ),
            ),
          ]),
    )));
  }
}

class SuccessRegisterScreen extends StatefulWidget {
  const SuccessRegisterScreen({super.key});

  @override
  State<SuccessRegisterScreen> createState() => _SuccessRegisterState();
}

class _SuccessRegisterState extends State<SuccessRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/done1.png',
                          width: 120,
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 100, left: 90.0),
                        child: SizedBox(width: 10),
                      ),
                      const Text(
                        "Congratulations!",
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 40,
                        ),
                        child: SizedBox(width: 10),
                      ),
                      const Text(
                        "You Have Successfully Registered",
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginLearnerScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the radius as needed
                      ),
                      backgroundColor: Color(hexColor(
                          '#024362')), // Set your preferred background color
                    ),
                    child: const Text(
                      'Proceed to Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder loginInputBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.grey, width: 3),
  );
}

OutlineInputBorder loginFocusedBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.red, width: 3),
  );
}

int hexColor(String color) {
  String newColor = '0xff' + color.replaceAll('#', '');
  return int.parse(newColor);
}
