import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Controller/request_controller.dart';
import '../../Repo/Authentication/learner_repo.dart';
import '../mainview/splash_screen3.dart';
import '../widget/custom_colour.dart';
import '../mainview/homepage_learner.dart';

void main() {
  runApp(const MaterialApp(
    home: LoginLearnerScreen(),
  ));
}

class LoginLearnerScreen extends StatefulWidget {
  const LoginLearnerScreen({Key? key}) : super(key: key);

  @override
  _LoginLearnerScreenState createState() => _LoginLearnerScreenState();
}

class _LoginLearnerScreenState extends State<LoginLearnerScreen> {
  bool _obscureText = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 50, 0, 0),
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
                Image.asset(
                  "assets/img/logo.png",
                  width: 480,
                  height: 300,
                ),
                const SizedBox(height: 5), // Adjust the space between the image and text
                const Text(
                  'Login',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 25.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          border: loginInputBorder(),
                          enabledBorder: loginInputBorder(),
                          focusedBorder: loginFocusedBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              !_obscureText ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                          border: loginInputBorder(),
                          enabledBorder: loginInputBorder(),
                          focusedBorder: loginFocusedBorder(),
                        ),
                        obscureText: _obscureText,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 260,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Call the login function and await its result
                      int result = await login(phoneController.text, passwordController.text);
                      // Handle the result if needed
                      // For example, you can check the result and show a toast message accordingly
                      if (result == 1) {

                        print('BOLEHHHHHHHHHHH');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) =>  HomePageLearner(),
                      ));
                      } else {
                        // Login failed
                        // Show an error message
                        Fluttertoast.showToast(msg: 'Login failed');
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: TColor.secondaryColor2,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder loginInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.grey, width: 3),
  );
}

OutlineInputBorder loginFocusedBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: TColor.secondaryColor2, width: 3),
  );
}
