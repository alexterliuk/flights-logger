import 'package:flights_logger/src/db/queries.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
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
