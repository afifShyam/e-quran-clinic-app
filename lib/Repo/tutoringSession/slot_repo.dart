import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Request/requestAPI.dart';

Future<void> bookSelectedSlots(List<bool> selectedSlots,
    List<DateTime> timeSlots, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int tutorID = prefs.getInt('id') ?? 1;
  print('Tutor ID: $tutorID');
  List<Map<String, dynamic>> slotsToBook = [];
  for (int i = 0; i < selectedSlots.length; i++) {
    if (selectedSlots[i]) {
      slotsToBook.add({
        'date_time': timeSlots[i].toIso8601String(),
        'status': 'available',
        'tutor_id': tutorID // Assuming a tutor_id is available
      });
    }
  }

  if (slotsToBook.isEmpty) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("No slots selected")));
    return;
  }

// Send the slotsToBook to the API
  try {
    final response = await http.post(
      Uri.parse(requestAPI.createMultipleSlots),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'slots': slotsToBook}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Slots booked successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to book slots")));
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Error: $e")));
  }
}

Future<void> createSlot(DateTime date, BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  final int tutorId = prefs.getInt('tutor_id') ??
      1; // Replace with the actual tutor ID if stored

  try {
    final response = await http.post(
      Uri.parse(requestAPI.availableSlot),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'date_time': date.toIso8601String(),
        'status': 'booked',
        'tutor_id': tutorId,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Slot booked successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book slot: ${response.body}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

Future<List<dynamic>> fetchSlots() async {
  final response = await http.get(
    Uri.parse(requestAPI.availableSlot),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load slots');
  }
}


