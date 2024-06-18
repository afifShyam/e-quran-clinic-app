import 'package:e_quranclinic/View/tutorsession/tutoring_progress_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Repo/Authentication/tutor_repo.dart';
import 'tutor_card.dart';
import 'profile_tutor.dart';

class ViewVerifiedTutor extends StatefulWidget {
  @override
  _ViewVerifiedTutorState createState() => _ViewVerifiedTutorState();
}

class _ViewVerifiedTutorState extends State<ViewVerifiedTutor> {
  List tutors = [];

  @override
  void initState() {
    super.initState();
    fetchTutors().then((data) {
      setState(() {
        tutors = data;
      });
    });
  }

  Future<void> _selectTutor(Map<String, dynamic> tutor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedTutorId', tutor['id']);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileTutorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.teal[200],
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/img/logo.png'),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Current Tutor",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 120,
              child: tutors.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                scrollDirection: Axis.horizontal,
                children: tutors.map((tutor) {
                  return TutorCard(
                    tutor: tutor,
                    onSelect: () => _selectTutor(tutor),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Tutoring Progress",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  TutoringProgressCard(),
                  TutoringProgressCard(),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Other Tutors",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Search Tutors",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 120,
              child: tutors.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                scrollDirection: Axis.horizontal,
                children: tutors.map((tutor) {
                  return TutorCard(
                    tutor: tutor,
                    onSelect: () => _selectTutor(tutor),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
