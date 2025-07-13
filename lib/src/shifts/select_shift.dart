import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../shifts/shifts_loading.dart';
import '../calendar/calendar_period.dart';

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
    var appState = context.watch<MyAppState>();

    void showShifts({ required DateTime fromDate, required DateTime toDate }) {
      appState.setSelectedShiftsMode(fromDate, toDate);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
          ShiftsLoading(fromDate: fromDate, toDate: toDate),
        ),
      );
    }

    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                CalendarPeriod(callback: showShifts),
              ),
            );
          },
        ),
      ],
    );
  }
}
