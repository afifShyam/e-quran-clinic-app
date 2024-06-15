import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookSlot extends StatefulWidget {
  final DateTime selectedDate;

  BookSlot({required this.selectedDate});

  @override
  _BookSlotState createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  List<DateTime> timeSlots = [];
  List<bool> selectedSlots = [];

  @override
  void initState() {
    super.initState();
    generateTimeSlots();
    loadSelectedSlots(); // Load previously selected slots from SharedPreferences
  }

  void generateTimeSlots() {
    DateTime currentDate = DateTime(widget.selectedDate.year, widget.selectedDate.month, widget.selectedDate.day);
    DateTime startTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 8);
    DateTime endTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 21, 30);

    while (startTime.isBefore(endTime)) {
      timeSlots.add(startTime);
      startTime = startTime.add(Duration(minutes: 30));
    }
  }

  Future<void> loadSelectedSlots() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<bool> loadedSelectedSlots = [];
    for (int i = 0; i < timeSlots.length; i++) {
      bool isSelected = prefs.getBool('slot_$i') ?? false;
      loadedSelectedSlots.add(isSelected);
    }
    setState(() {
      selectedSlots = loadedSelectedSlots;
    });
  }

  Future<void> saveSelectedSlots() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < selectedSlots.length; i++) {
      await prefs.setBool('slot_$i', selectedSlots[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text("Book Slot for ${widget.selectedDate.toLocal().toString().split(' ')[0]}"), // Display only the date part
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: Text(
                "Select All",
                style: TextStyle(fontSize: 16),
              ),
              value: selectedSlots.isNotEmpty && selectedSlots.every((selected) => selected),
              onChanged: (bool? value) {
                setState(() {
                  selectedSlots = List.generate(selectedSlots.length, (index) => value ?? false);
                  saveSelectedSlots(); // Save selected slots when "Select All" checkbox is toggled
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      "Slot ${index + 1}: ${timeSlots[index].hour}:${timeSlots[index].minute.toString().padLeft(2, '0')}",
                      style: TextStyle(fontSize: 16),
                    ),
                    value: selectedSlots.isNotEmpty && index < selectedSlots.length ? selectedSlots[index] : false,
                    onChanged: (bool? value) {
                      setState(() {
                        if (selectedSlots.isNotEmpty && index < selectedSlots.length) {
                          selectedSlots[index] = value ?? false;
                          saveSelectedSlots(); // Save selected slots when any individual checkbox is toggled
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
