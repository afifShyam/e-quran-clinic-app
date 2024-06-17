import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileTutorPage extends StatefulWidget {
  final int tutorId;

  ProfileTutorPage({required this.tutorId});

  @override
  _ProfileTutorPageState createState() => _ProfileTutorPageState();
}

class _ProfileTutorPageState extends State<ProfileTutorPage> {
  Map<String, dynamic>? tutor;

  @override
  void initState() {
    super.initState();
    fetchTutor(widget.tutorId).then((data) {
      setState(() {
        tutor = data;
      });
    });
  }

  Future<Map<String, dynamic>> fetchTutor(int id) async {
    final response = await http.get(Uri.parse('http://192.168.1.155:8000/tutor/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load tutor data');
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
                // Handle book tutoring session button press
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
}
