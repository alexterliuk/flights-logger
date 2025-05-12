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

  onDateChanged (DateTime d) {
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

    // DateTime today = DateTime.now();
    DateTime firstDate = DateTime(2024, 7, 4, 9, 31);
    DateTime lastDate = DateTime(2024, 7, 29, 23, 57);
    DateTime initialDate = DateTime(2024, 7, 11);

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















class CalendarStateful extends StatefulWidget {
  const CalendarStateful({
    super.key,
    required this.callback,
  });

  final void Function({ required DateTime fromDate, required DateTime toDate }) callback;

  @override
  createState() {
    return CalendarState();
  }
}

class CalendarState extends State<CalendarStateful> {
  DateTime firstDate = (int year) { return DateTime(year - 3); }(DateTime.now().year);
  DateTime lastDate = (int year) { return DateTime(year + 1); }(DateTime.now().year);
  DateTime initialDate = DateTime.now();

  DateTime? fromDate;
  bool stepOne = true;
  // List<DateTime> forbiddenDates = [];

  void reset() {
    fromDate = null;
    stepOne = true;
    // forbiddenDates.clear();3
  }

  void onDateChanged(DateTime d) {
    // print(d); // DateTime 2024-07-10 00:00:00.000
    // print('iso 8601: ${d.toIso8601String()}'); // 2024-07-10T00:00:00.000
    print('date picked toString: ${d.toString()}'); // 2024-07-10 00:00:00.000

    if (stepOne) {
      stepOne = false;
      fromDate = d;

      return;
    }

    DateTime from = fromDate ?? firstDate;
    DateTime to = d;

    reset();

    widget.callback(fromDate: from, toDate: to);
  }

  bool selectableDayPredicate(DateTime d) {
    // DateTime? foundDate = forbiddenDates
    if (fromDate is DateTime) {
      // TODO: to allow selection the same date twice (so that from and to is equal)
      // make smth like d.subtract(Duration).isAfter...
      return d.isAfter(fromDate as DateTime);
      // return d.isAtSameMomentAs(initialDate as DateTime);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CalendarDatePicker(
            // currentDate: today,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
            onDateChanged: onDateChanged,
            selectableDayPredicate: selectableDayPredicate,
          ),
        ],
      ),
    );
  }
}
