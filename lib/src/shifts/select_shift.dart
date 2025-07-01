import 'package:flutter/material.dart';

import '../calendar/calendar_period.dart';
import './shifts.dart';

// class ShowCalendar with ChangeNotifier {
//   var isShown = false;

//   void show() {
//     ShowCalendar.update()
//     expandedView.update(index, (value) => !value, ifAbsent: () => value);
//     notifyListeners();
//     print('expandedView: $expandedView');
//   }

//   bool isExpanded(int index) {
//     return expandedView.putIfAbsent(index, () => false);
//   }
// }

// class SelectShift extends StatefulWidget {
//   SelectShift({
//     super.key,
//   });

//   bool isCalendarShown = false;

//   @override
//   SelectState createState() {
//     return FlightLogFormState();
//   }
// }

class SelectShift extends StatelessWidget {
  const SelectShift({
    super.key,
  });

  static const routeName = '/select-shift';

  @override
  Widget build(BuildContext context) {
    void showShifts({ required DateTime fromDate, required DateTime toDate }) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Shifts(fromDate: fromDate, toDate: toDate)),
      );
    }

    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPeriod(callback: showShifts)),
            );
          },
        ),
      ],
    );
  }
}
