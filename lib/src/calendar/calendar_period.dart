import 'package:flutter/material.dart';

class CalendarPeriod extends StatefulWidget {
  const CalendarPeriod({
    super.key,
    required this.callback,
  });

  final void Function({ required DateTime fromDate, required DateTime toDate }) callback;

  @override
  createState() {
    return CalendarState();
  }
}

class CalendarState extends State<CalendarPeriod> {
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
    // print('date picked toString: ${d.toString()}'); // 2024-07-10 00:00:00.000

    if (stepOne) {
      stepOne = false;
      fromDate = d;

      return;
    }

    DateTime from = fromDate ?? firstDate;
    // adding one day to include items ended till 23:59 of d
    DateTime to = d.add(const Duration(days: 1));

    reset();

    widget.callback(fromDate: from, toDate: to);
  }

  bool selectableDayPredicate(DateTime d) {
    // DateTime? foundDate = forbiddenDates
    if (fromDate is DateTime) {
      // allow selecting the same date twice (so that from and to is equal)
      return d.add(const Duration(days: 1)).isAfter(fromDate as DateTime);
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
