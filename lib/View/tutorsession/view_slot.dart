import 'package:e_quranclinic/View/widget/bottom_navigationbar_tutor.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../main.dart';
import '../widget/custom_appbar.dart';
import '../widget/default_appbar.dart';
import 'book_slot.dart';

void main() {
  runApp(MyApp());
}

class ViewSlot extends StatefulWidget {
  @override
  _ViewSlotState createState() => _ViewSlotState();
}

class _ViewSlotState extends State<ViewSlot> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booked Slots",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                firstDay: DateTime(2020),
                lastDay: DateTime(2030),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDate, day);
                },
                onDaySelected: (selectedDate, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDate;
                    _focusedDay = focusedDay;
                  });
                  // Navigate to BookSlot page or show a dialog to book the slot
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookSlot(selectedDate: _selectedDate!)),
                  );
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TutorNavigationBarWidget(),
    );
  }
}
