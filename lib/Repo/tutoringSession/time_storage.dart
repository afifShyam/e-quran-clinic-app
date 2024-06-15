import 'package:shared_preferences/shared_preferences.dart';

class TimeStorage {
  static const String _prefix = 'selected_time_'; // Prefix for keys

  // Store a selected time
  static Future<void> storeSelectedTime(DateTime time) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String key = _getKey(time);
      prefs.setString(key, time.toString());
    } catch (e) {
      print('Error storing selected time: $e');
    }
  }

  // Retrieve all selected times
  static Future<List<DateTime>> getSelectedTimes() async {
    List<DateTime> selectedTimes = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Set<String> keys = prefs.getKeys().where((key) => key.startsWith(_prefix)).toSet();
      for (String key in keys) {
        String? timeString = prefs.getString(key);
        if (timeString != null) {
          selectedTimes.add(DateTime.parse(timeString));
        }
      }
    } catch (e) {
      print('Error retrieving selected times: $e');
    }
    return selectedTimes;
  }

  // Delete a selected time
  static Future<void> deleteSelectedTime(DateTime time) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String key = _getKey(time);
      prefs.remove(key);
    } catch (e) {
      print('Error deleting selected time: $e');
    }
  }

  // Generate a unique key for the time
  static String _getKey(DateTime time) {
    return '$_prefix${time.hour}_${time.minute}';
  }
}

// Example usage:
void main() async {
  // Store selected times
  await TimeStorage.storeSelectedTime(DateTime.now().add(Duration(hours: 1)));
  await TimeStorage.storeSelectedTime(DateTime.now().add(Duration(hours: 2)));

  // Retrieve selected times
  List<DateTime> selectedTimes = await TimeStorage.getSelectedTimes();
  print('Selected times: $selectedTimes');

  // Delete a selected time
  await TimeStorage.deleteSelectedTime(DateTime.now().add(Duration(hours: 1)));
}
