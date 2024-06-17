import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Request/requestAPI.dart';

Future<int> loginTutor(String phone_num, String password) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    var url = Uri.parse(requestAPI.loginURLTutor);

    // Serialize the data Map to JSON
    var body = json.encode({
      'phone_num': phone_num,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic>? responseData = json.decode(response.body);
      if (responseData != null) {
        print ({'Response data---$responseData'});
        String token = responseData['token'] ?? '';
        String phone = responseData['tutor']['phone_num'] ?? '';
        String email = responseData['tutor']['email'] ?? '';
        String password = responseData['tutor']['password'] ?? '';
        String profilePicture = responseData['tutor']['profile_picture'] ?? '';
        int age = responseData['tutor']['age'] ?? 0;
        String gender = responseData['tutor']['gender'] ?? '';
        String status = responseData['tutor']['status'] ?? '';
        String name = responseData['tutor']['name'] ?? '';
        int tutorID = responseData['tutor']['id'] ?? 0;
        print('Tutor ID: $tutorID');

        // Store the data using shared preferences
        await pref.setString("token", token);
        await pref.setString("name", name);
        await pref.setString("phone_num", phone);
        await pref.setString("email", email);
        await pref.setString("password", password);
        await pref.setString("profile_picture", profilePicture);
        await pref.setInt("age", age);
        await pref.setString("gender", gender);
        await pref.setString("status", status);
        await pref.setInt("id", tutorID);

        print('TUTOR NAME : $name');
        print('TOKEN : $token');
        return 1; // Success
      } else {
        print('Login failed: Empty response body');
        return 0; // Failure
      }
    } else if (response.statusCode == 403) {
      // Handle different status codes
      print('Login failed with status code: ${response.statusCode}');
      return 3; // Account is not active
    } else {
      // Handle different status codes
      print('Login failed with status code: ${response.statusCode}');
      return 0; // Failure
    }
  } catch (e) {
    print('Login error: $e');
    return 2; // Error
  }
}

Future<int> registerTutor(
    String name,
    String about,
    String phone_num,
    String email,
    String password,
    String profile_picture,
    int age,
    String gender,
    String document,
    String status) async {
  var pref = await SharedPreferences.getInstance();
  try {
    var url = Uri.parse(requestAPI.RegisterTutorURL);

    var body = json.encode({
      "name": name,
      "about": about,
      "phone_num": phone_num,
      "email": email,
      "password": password,
      "profile_picture": profile_picture,
      "age": age,
      "gender": gender,
      "document": document,
      "status": status,
    });

    print("Request URL: $url");
    print("Request Headers: ${{"Content-Type": "application/json"}}");
    print("Request Body: $body");

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      String data = response.body;
      pref.setString("token", data);
      return 1;
    } else {
      print('Registration failed with status code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return 0;
    }
  } catch (e) {
    print('Error during registration');
    print(e.toString());
    return 2;
  }
}

Future<List> fetchTutors() async {
  try {
    // Debug: print the URL
    var url = Uri.parse(requestAPI.viewVerifiedTutors);
    print('Fetching tutors from $url');

    final response = await http.get(url);
    print('Response status: ${response.statusCode}'); // Debug: print the response status code

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('Response data: $data'); // Debug: print the response data
      return data['tutors']; // Ensure this key matches your JSON response
    } else {
      print('Failed to load tutors: ${response.statusCode}');
      print('Response body: ${response.body}'); // Debug: print the response body
      return [];
    }
  } catch (e) {
    print('Error fetching tutors: $e');
    return [];
  }
}
Future<Map<String, dynamic>> fetchTutor(int id) async {
  final response = await http.get(Uri.parse(requestAPI.viewProfileTutor));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load tutor data');
  }
}

Future<bool> refreshTokenTutor() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  try {
    var url = Uri.parse(requestAPI.refreshURL);
    String? phone_num = pref.getString('phone_num');
    String? token = pref.getString('token');

    if (phone_num != null && token != null) {
      var headers = {
        "Content-Type": "application/json",
        "phone_num": phone_num,
        "Authorization": "Bearer $token",
      };

      var response = await http.put(url, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        String newToken = jsonData['token'];
        await pref.setString("token", newToken);
        return true; // Token refreshed successfully
      } else {
        print(
            'Failed to refresh token with status code: ${response.statusCode}');
        return false;
      }
    }
    return false; // Phone_num or token not available
  } catch (e) {
    print('Error in refreshing token: $e');
    return false;
  }
}

