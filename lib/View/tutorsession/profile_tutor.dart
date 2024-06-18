import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Repo/Request/requestAPI.dart';

class ProfileTutorPage extends StatefulWidget {
  @override
  _ProfileTutorPageState createState() => _ProfileTutorPageState();
}

class _ProfileTutorPageState extends State<ProfileTutorPage> {
  Map<String, dynamic>? tutor;
  List<DateTime> availableSlots = [];
  int? tutorId;

  @override
  void initState() {
    super.initState();
    fetchTutorId().then((id) {
      setState(() {
        tutorId = id;
      });
      fetchTutor(id).then((data) {
        setState(() {
          tutor = data;
        });
      });
      fetchAvailableSlots(id).then((slots) {
        setState(() {
          availableSlots = slots;
        });
      });
    });
  }

  Future<int> fetchTutorId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('selectedTutorId')!;
  }

  Future<Map<String, dynamic>> fetchTutor(int id) async {
    final response = await http.get(Uri.parse('${requestAPI.ipaddress}tutor/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load tutor data');
    }
  }

  Future<List<DateTime>> fetchAvailableSlots(int tutorId) async {
    final response = await http.get(Uri.parse('${requestAPI.ipaddress}tutor/$tutorId/available-slots'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((slot) => DateTime.parse(slot['date_time'])).toList();
    } else {
      throw Exception('Failed to load available slots');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutor Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: tutor == null
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(tutor!['profile_picture']),
            ),
            SizedBox(height: 16),
            Text(
              tutor!['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Age: ${tutor!['age']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              tutor!['about'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text(tutor!['phone_num']),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text(tutor!['email']),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showBookingDialog();
              },
              child: Text('Book Tutoring Session'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: BookingDialogContent(tutor: tutor, availableSlots: availableSlots),
        );
      },
    );
  }
}

class BookingDialogContent extends StatefulWidget {
  final Map<String, dynamic>? tutor;
  final List<DateTime> availableSlots;

  BookingDialogContent({this.tutor, required this.availableSlots});

  @override
  _BookingDialogContentState createState() => _BookingDialogContentState();
}

class _BookingDialogContentState extends State<BookingDialogContent> {
  String selectedType = 'monthly';
  DateTime? selectedDateTime;
  int? learnerId;

  @override
  void initState() {
    super.initState();
    fetchLearnerId().then((id) {
      setState(() {
        learnerId = id;

        print('student ni nak book session $learnerId');
      });
    });
  }

  Future<int> fetchLearnerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id')!; // Ensure you have saved learner ID in shared preferences
  }

  Future<void> _bookTutoringSession() async {
    if (selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a date and time.")));
      return;
    }

    try {
      await bookTutoringSession(learnerId!, widget.tutor!['id'], selectedDateTime!.toIso8601String(), selectedType);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Tutoring session booked successfully!")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to book tutoring session")));
    }
  }

  Future<void> bookTutoringSession(int learnerId, int tutorId, String dateTime, String type) async {
    final response = await http.post(
      Uri.parse('${requestAPI.ipaddress}create-booking'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'learner_id': learnerId,
        'tutor_id': tutorId,
        'slots': [dateTime], // Wrap the dateTime in a list to match the 'slots' field
        'type': type,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to book session');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Text(
                'Tutor Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Booking Session',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: DropdownButton<String>(
              value: selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              items: <String>['monthly', 'weekly', 'daily'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            subtitle: Text('Session Type'),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.tutor!['profile_picture']),
            ),
            title: Text(widget.tutor!['name']),
            subtitle: Text('Tutor'),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: DropdownButton<DateTime>(
              hint: Text('Select Date & Time'),
              value: selectedDateTime,
              onChanged: (DateTime? newValue) {
                setState(() {
                  selectedDateTime = newValue!;
                });
              },
              items: widget.availableSlots.map<DropdownMenuItem<DateTime>>((DateTime value) {
                return DropdownMenuItem<DateTime>(
                  value: value,
                  child: Text('${value.hour}:${value.minute} | ${value.day}/${value.month}/${value.year}'),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _bookTutoringSession,
            child: Center(
              child: Text('Book Tutoring Session'),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(vertical: 15),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
