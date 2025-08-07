import 'package:flutter/material.dart';

enum CalendarSelectable {
  shift,
  log,
}

class Calendar extends StatelessWidget {
  const Calendar({
    super.key,
    // required this.type,
    required this.callback,
  });

  // final CalendarSelectable type;
  final void Function(DateTime) callback;

  // static String trimSeconds (String dateString) {
  //   // e.g. 2024-07-10 08:44:00.000 -->
  //   //      2024-07-13 08:44
  //   return dateString.substring(0, 16);
  // }

  static const routeName = '/calendar';

  void onDateChanged (DateTime d) {
    // print('date picked');
    // print(d); // DateTime 2024-07-10 00:00:00.000
    // print('iso 8601: ${d.toIso8601String()}'); // 2024-07-10T00:00:00.000
    print('date picked toString: ${d.toString()}'); // 2024-07-10 00:00:00.000

    callback(d);      
  }

  @override
  Widget build(BuildContext context) {
    // onDateChanged (DateTime d) {
    //   // print('date picked');
    //   // print(d); // DateTime 2024-07-10 00:00:00.000
    //   // print('iso 8601: ${d.toIso8601String()}'); // 2024-07-10T00:00:00.000
    //   print('date picked toString: ${d.toString()}'); // 2024-07-10 00:00:00.000

    //   callback(d);      
    // }

    DateTime firstDate = (int year) { return DateTime(year - 3); }(DateTime.now().year);
    // restrict selection by today
    DateTime lastDate = DateTime.now();
    DateTime initialDate = DateTime.now();

    return Scaffold(
      body: Column(
        children: [
          CalendarDatePicker(
            // currentDate: today,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
            onDateChanged: onDateChanged,
          ),
        ],
      ),
    );
  }
}
