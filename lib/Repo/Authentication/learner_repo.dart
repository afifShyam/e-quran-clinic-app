import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Request/requestAPI.dart';


  Future<int> login(String phone_num, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      var url = Uri.parse(requestAPI.loginURL);

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
        Map<String, dynamic> responseData = json.decode(response.body);
        String token = responseData['token'];

        // Store the token using shared preferences
        await pref.setString("token", token);
        await pref.setString("phone_num", phone_num);
        return 1;  // Success
      } else {
        // Handle different status codes
        print('Login failed with status code: ${response.statusCode}');
        return 0;  // Failure
      }
    } catch (e) {
      print('Login error: $e');
      return 2;  // Error
    }
  }


Future<int> registerLearner(String name, String gender, int age, String phone_num,
    String password, String proficiencyLevel,
    ) async{
  var pref = await SharedPreferences.getInstance();
  try{

    var url = Uri.parse(requestAPI.RegisterURL);

    var body = json.encode({
      "name": name,
      "gender": gender,
      "age": age,
      "phone_num": phone_num,
      "password": password,
      "proficiency_level": proficiencyLevel,
    });

    print(body.toString());
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );

    if (response.statusCode == 200){
      String data =  response.body;
      pref.setString("token", data);
      return 0;
    }
    else {
      String data =  response.body;
      if(data[0] == 'U'){
        // username duplicated
        return 1;
      } else if (data[0] == 'E') {
        // email duplicated
        return 2;
      }
    }
    return 3;

  } catch (e) {
    print('error in register');
    print(e.toString());
    return 3;
  }
}

  Future<bool> refreshToken() async {
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
          return true;  // Token refreshed successfully
        } else {
          print('Failed to refresh token with status code: ${response.statusCode}');
          return false;
        }
      }
      return false;  // Phone_num or token not available
    } catch (e) {
      print('Error in refreshing token: $e');
      return false;
    }
  }

