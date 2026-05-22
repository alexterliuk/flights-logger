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

class SelectShifts extends StatelessWidget {
  const SelectShifts({
    super.key,
  });

  static const routeName = '/select-shifts';

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

    // return Column(
    //   children: [
    //     IconButton(
    //       icon: const Icon(Icons.settings),
    //       onPressed: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) =>
    //             CalendarPeriod(callback: showShifts),
    //           ),
    //         );
    //       },
    //     ),
    //   ],
    // );
    // return FilledButton(
    //   onPressed: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) =>
    //         CalendarPeriod(callback: showShifts),
    //       ),
    //     );
    //   },
    //   child: const Text(
    //     'Calendar',
    //     // style: TextStyle(color: Colors.black87),
    //     style: TextStyle(color: Colors.black87),
    //   ),
    // );
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
            CalendarPeriod(callback: showShifts),
          ),
        );
      },
      // style: ButtonStyle(backgroundColor: const Color(0xFF2D3E50)),
      // style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(100, 3, 169, 244)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        // backgroundColor: Colors.deepPurpleAccent,
        // backgroundColor: Colors.blue,
        // backgroundColor: Colors.blueGrey,
        backgroundColor: Colors.indigo, // !!!
        // foregroundColor: Colors.white,
        // backgroundColor: Colors.teal.shade600,

        // foregroundColor: Colors.amber.shade400,
        // backgroundColor: Colors.blueGrey.shade900,

        // foregroundColor: Colors.black87,
        // backgroundColor: Colors.orangeAccent.shade700,

        elevation: 8,
        // shadowColor: Colors.deepPurpleAccent.withValues(alpha: 0.5),
        // shadowColor: Colors.blueGrey.withValues(alpha: 0.5),
        shadowColor: Colors.indigo.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      // style: ButtonStyle(
      //   shape: WidgetStateProperty.all(
      //     RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //   ),
      //   // backgroundColor: WidgetStateProperty.all(Color.fromARGB(100, 100, 100, 100)),
      //   backgroundColor: WidgetStateProperty.all(Color.fromARGB(
      //       50, 4, 51, 227)),
      //   // foregroundColor: WidgetStatePropertyAll(Colors.white),
      // ),
      child: const Text(
        'Select shifts',
        style: TextStyle(
          // color: Colors.black87
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
