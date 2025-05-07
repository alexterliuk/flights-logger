import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../settings/settings_view.dart';
import '../table_methods/table_methods.dart';
import './shift_model.dart';
import './shift.dart';

class ShiftsArguments {
  final DateTime fromDate;
  final DateTime toDate;

  ShiftsArguments(this.fromDate, this.toDate);
}

class ShiftsState extends TableMethods {}

class Shifts extends StatelessWidget {
  const Shifts({
    super.key,
    this.fromDate,
    this.toDate,
  });

  final DateTime? fromDate;
  final DateTime? toDate;

  static const routeName = '/shifts';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    // print('fromDate: $fromDate');
    // print('toDate: $toDate');
    final to = toDate ?? DateTime.now();
    final from = fromDate ?? to.subtract(const Duration(days: 14));

    Future.delayed(Duration.zero, () async {
      if (!appState.hasShiftsSelectionEnded) {
        appState.updateSelectedShifts(from, to);
        // print('Future selectedShifts: ${appState.selectedShifts}');
        appState.update();
      }
    });

    Future.delayed(const Duration(seconds: 1), () async {
      appState.resetShiftsSelection();
    });

    return ChangeNotifierProvider(
      create: (context) => ShiftsState(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shifts'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
            // IconButton(
            //   icon: const Icon(Icons.abc),
            //   onPressed: () {
            //     // Navigate to the settings page. If the user leaves and returns
            //     // to the app after it has been killed while running in the
            //     // background, the navigation stack is restored.
            //     Navigator.restorablePushNamed(context, '/flight_log_form');
            //   },
            // ),
          ],
        ),

        body:
          ListView.builder(
            restorationId: 'shifts',
            itemCount: appState.selectedShifts.length,
            itemBuilder: (BuildContext context, int index) {
              final shift = appState.selectedShifts[index];

              return Shift(shift: shift, index: index);
            },
          ),
      ),
    );
  }
}










// class Shifts extends StatelessWidget {
//   const Shifts({
//     super.key,
//     this.fromDate,
//     this.toDate,
//   });

//   final DateTime? fromDate;
//   final DateTime? toDate;

//   static const routeName = '/shifts';
  
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();
//     List<ShiftModel> selectedShifts = appState.selectedShifts;

//     final to = toDate ?? DateTime.now();
//     final from = fromDate ?? to.subtract(const Duration(days: 14));

//     Future.delayed(Duration.zero, () async {
//       appState.updateSelectedShifts(from, to);
//       appState.update();
//     });

//     return ChangeNotifierProvider(
//       create: (context) => ShiftsState(),
//       child: ShiftsList(shifts: selectedShifts),
//     );
//   }
// }




// class ShiftsList extends StatelessWidget {
//   ShiftsList({
//     super.key,
//     this.shifts = const [],
//   });

//   final List<ShiftModel> shifts;
  
//   @override
//   Widget build(BuildContext context) {
//     // return ChangeNotifierProvider(
//     //   create: (context) => ShiftsState(),
//     //   child: Scaffold(
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Shifts'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.settings),
//               onPressed: () {
//                 // Navigate to the settings page. If the user leaves and returns
//                 // to the app after it has been killed while running in the
//                 // background, the navigation stack is restored.
//                 Navigator.restorablePushNamed(context, SettingsView.routeName);
//               },
//             ),
//             // IconButton(
//             //   icon: const Icon(Icons.abc),
//             //   onPressed: () {
//             //     // Navigate to the settings page. If the user leaves and returns
//             //     // to the app after it has been killed while running in the
//             //     // background, the navigation stack is restored.
//             //     Navigator.restorablePushNamed(context, '/flight_log_form');
//             //   },
//             // ),
//           ],
//         ),

//         // To work with lists that may contain a large number of items, it’s best
//         // to use the ListView.builder constructor.
//         //
//         // In contrast to the default ListView constructor, which requires
//         // building all Widgets up front, the ListView.builder constructor lazily
//         // builds Widgets as they’re scrolled into view.

//         body:
//           ListView.builder(
//             // Providing a restorationId allows the ListView to restore the
//             // scroll position when a user leaves and returns to the app after it
//             // has been killed while running in the background.
//             restorationId: 'shifts',
//             // itemCount: shifts.length,
//             itemCount: shifts.length,
//             itemBuilder: (BuildContext context, int index) {
//               final shift = shifts[index];

//               return Shift(shift: shift, index: index);
//             },
//           ),
//       );
//     // );
//   }
// }
