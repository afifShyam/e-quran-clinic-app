import 'dart:developer';

import 'package:e_quranclinic/View/authentication/register_tutor.dart';
import 'package:e_quranclinic/View/mainview/splash_screen3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Controller/request_controller.dart';
import '../../Repo/Authentication/learner_repo.dart';
import '../../Repo/Authentication/tutor_repo.dart';
import '../../main.dart';
import '../mainview/homepage_learner.dart';
import '../mainview/homepage_tutor.dart';
import '../widget/custom_appbar.dart';

class LoginTutorScreen extends StatefulWidget {
  const LoginTutorScreen({Key? key}) : super(key: key);

  @override
  _LoginTutorScreenState createState() => _LoginTutorScreenState();
}

class _LoginTutorScreenState extends State<LoginTutorScreen> {
  bool _obscureText = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BackgroundContainer(
          // Use BackgroundContainer here
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen3()),
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
                    height: 330,
                  ),
                  const SizedBox(height: 5),
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
                    padding: const EdgeInsets.only(
                        right: 30.0, left: 30.0, bottom: 10, top: 10.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: const Icon(Icons.phone),
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
                    padding: const EdgeInsets.only(
                        right: 30.0, left: 30.0, bottom: 20, top: 5.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                !_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        int result = await loginTutor(
                            phoneController.text, passwordController.text);
                        if (result == 1) {
                          log('BOLEHHHHHHHHHHH');
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NavigationManager()),
                            );
                          }
                        } else if (result == 3) {
                          Fluttertoast.showToast(
                              msg:
                                  'Account has not been activated yet. Please contact administrator');
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Invalid phone number / password');
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: TColor.primaryColor2,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have account yet? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterTutorScreen())); //go to register screen
                            });
                          },
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              color: TColor.primaryColor2,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    borderSide: BorderSide(color: TColor.secondaryColor2, width: 3),
  );
}
