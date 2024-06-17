import 'package:flutter/material.dart';

class TutorCard extends StatelessWidget {
  final Map<String, dynamic> tutor;
  final VoidCallback onSelect;

  TutorCard({required this.tutor, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Card(
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(tutor['profile_picture']),
            ),
            Text(tutor['name']),
          ],
        ),
      ),
    );
  }
}
