import 'package:flights_logger/src/db/queries.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import 'shift_model.dart';
import 'shifts_new.dart';

class ShiftsLoading extends StatefulWidget {
  const ShiftsLoading({
    super.key,
  });

  static const routeName = '/shifts_loading';

  @override
  State<ShiftsLoading> createState() =>
      ShiftsLoadingState();
}

class ShiftsLoadingState extends State<ShiftsLoading> {
  Future<ShiftsResult>? shiftsResult;

  @override
  void initState() {
    super.initState();
    loadShifts();
  }

  void loadShifts() {
    Future<ShiftsResult> loadedShiftsResult = getShiftsFromDb(offset: 0, limit: 20);

    setState(() {
      shiftsResult = loadedShiftsResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return FutureBuilder(
      future: shiftsResult,
      builder:(context, AsyncSnapshot<ShiftsResult> snapshot) {
        if (snapshot.hasData) {
          // apply logic only for initial load
          if (appState.shiftsRes.shifts.isEmpty) {
            appState.updateShiftsRes(snapshot.data ?? ShiftsResult(shifts: []));
            appState.addToHistory(ShiftsNew.routeName);
          }

          return const ShiftsNew();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Shifts'),
            ),

            body: const Center(
              // widthFactor: 10,
              heightFactor: 10,
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
  }
}



















// class ShiftsLoading extends StatefulWidget {
//   const ShiftsLoading({
//     super.key,
//     this.tc = 0,
//   });

//   final int tc;

//   static const routeName = '/shifts_loading';

//   @override
//   State<ShiftsLoading> createState() =>
//       ShiftsLoadingState();
// }

// class ShiftsLoadingState extends State<ShiftsLoading> {
//   // Future<List<ShiftModel>>? shifts;
//   Future<ShiftsResult>? shiftsResult;
//   // int tc = 0;

//   @override
//   void initState() {
//     /// 0
//     print('     [ShiftsLoading.initState]');
//     super.initState();
//     loadShifts();
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     super.didChangeDependencies();
//     print('-----------------------didChangeDependencies');
//   }

//   void loadShifts() {
//     /// 1
//     print('     [ShiftsLoading.loadShifts]');
//     // Future<List<ShiftModel>> loadedShifts = getShiftsFromDb(offset: 0, limit: 20);
//     Future<ShiftsResult> loadedShiftsResult = getShiftsFromDb(offset: 0, limit: 20);

//     setState(() {
//       // shifts = loadedShifts;
//       shiftsResult = loadedShiftsResult;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     widget.tc;
//     /// 2
//     var appState = context.watch<MyAppState>();

//     // if (appState.sho) {
//     //   appState.sho = false;
//     //   setState(() => tc = appState.shoInt);
//     // }

//     return FutureBuilder(
//       // future: shifts,
//       future: shiftsResult,
//       // builder:(context, AsyncSnapshot<List<ShiftModel>> snapshot) {
//       builder:(context, AsyncSnapshot<ShiftsResult> snapshot) {
//         if (snapshot.hasData) {

//           /// NB: when resetShifts called, shifts are refreshed and changes visible (no appState.replaceShift is called)
//           // appState.resetShifts();

//           // print('     [ShiftsLoading.FutureBuilder] snapshot.data length - ${snapshot.data?.length}');
//           print('[ShiftsLoading] snapshot.hasData - totCou - ${snapshot.data?.totalCount}');
//           print('[ShiftsLoading] snapshot.hasData - widget.tc - ${widget.tc}');
//           // appState.updateShifts(snapshot.data?.shifts ?? [], snapshot.data?.totalCount);

//           // appState.updateShifts(snapshot.data?.shifts ?? [], shiftsTotalCount: snapshot.data?.totalCount);
//           // appState.updateShifts(snapshot.data?.shifts ?? []);
//           // appState.updateShiftsTotalCouInit(snapshot.data?.totalCount ?? 0);

//           appState.updateShiftsRes(snapshot.data ?? ShiftsResult());
//           // appState.shiftsRes.totalCount = snapshot.data?.totalCount ?? 7;
//           // WORK (WHEN COMMENTING OUT THE NEXT LINE) ============================
//           // appState.updateShiftsTotalCount(snapshot.data?.totalCount ?? 0);

//           appState.addToHistory(ShiftsNew.routeName);
//           // print('     [ShiftsLoading.FutureBuilder] appState.shifts.length - ${appState.shifts.length}');
//           // return ShiftsNew(title: 'Shifts ${(snapshot.data ?? []).length} loading',);
//           // return ShiftsNew(title: 'Shifts ${snapshot.data?.totalCount ?? 0} loading');
//           return ShiftsNew(title: 'Shifts ${widget.tc == 0 ? snapshot.data?.totalCount : 0}');
//         } else {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Shifts'),
//             ),

//             body: const Center(
//               // widthFactor: 10,
//               heightFactor: 10,
//               child: CircularProgressIndicator()
//             ),
//           );
//         }
//       },
//     );
//   }
// }










// class ShiftsLoadingState extends State<ShiftsLoading> {
//   Future<List<ShiftModel>>? shifts;
//   bool isInitLoading = true;

//   void loadShifts() async {
//     Future<List<ShiftModel>> loadedShifts = getShiftsFromDb(offset: 0, limit: 20);

//     // await Future<void>.delayed(const Duration(seconds: 3));

//     setState(() {
//       isInitLoading = false;
//       shifts = loadedShifts;

//       shifts?.then((s) =>
//         print('     [ShiftsLoading.loadShifts setState] shifts length - ${s.length}')
//       );
//     });
//   }

//   @override
//   void initState() async {
//     super.initState();
//     loadShifts();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();

//     // if (isInitLoading) {
//     //   /// THIS DOESN'T WORK FOR INFINITE DOWNLOAD LOOP (IF NOT TO CHECK SHIFT'S ID in appState.updateShifts)
//     //   /// clear in case if shifts downloaded earlier
//     //   appState.resetShifts();
//     //   loadShifts();

//     //   shifts?.then((s) =>
//     //     print('     [ShiftsLoading.isInitLoading] shifts length - ${s.length}')
//     //   );
//     // }

//     return FutureBuilder(
//       future: shifts,
//       builder:(context, AsyncSnapshot<List<ShiftModel>> snapshot) {
//         if (snapshot.hasData) {

//           print('     [ShiftsLoading.FutureBuilder] snapshot.data length - ${snapshot.data?.length}');

//           appState.updateShifts(snapshot.data ?? []);

//           print('     [ShiftsLoading.FutureBuilder] appState.shifts.length - ${appState.shifts.length}');
//           return ShiftsNew(title: 'Shifts ${(snapshot.data ?? []).length}',);
//         } else {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Shifts'),
//             ),

//             body: const Center(
//               // widthFactor: 10,
//               heightFactor: 10,
//               child: CircularProgressIndicator()
//             ),
//           );
//         }
//       },
//     );
//   }
// }
