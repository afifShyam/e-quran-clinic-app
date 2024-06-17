import 'package:flutter/material.dart';

class TutoringProgressCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Perform the action you want when the card is dismissed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Card dismissed')),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Juz 1",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text("Ustazah Asma"),
              SizedBox(height: 5),
              Text("15/5/2024 08:00 - 09:00 AM"),
              SizedBox(height: 5),
              Text("Comments"),
              SizedBox(height: 5),
              LinearProgressIndicator(
                value: 0.9, // example progress value
              ),
            ],
          ),
        ),
      ),
    );
  }
}
