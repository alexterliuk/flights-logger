import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/queries.dart';
import '../app_state.dart';
import 'shifts.dart';

class ShiftsLoading extends StatefulWidget {
  const ShiftsLoading({
    super.key,
    this.fromDate,
    this.toDate,
  });

  final DateTime? fromDate;
  final DateTime? toDate;

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
    Future<ShiftsResult> loadedShiftsResult = getShiftsFromDb(
      fromDate: widget.fromDate,
      toDate: widget.toDate,
    );

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
            appState.addToHistory(Shifts.routeName);
          }

          return Shifts(fromDate: widget.fromDate, toDate: widget.toDate);
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
