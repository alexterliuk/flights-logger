import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../flight_log_form/flight_log_form.dart';
import '../flight_logs/flight_logs_header.dart';
import '../flight_logs/new_shift_flight_log.dart';
import '../flight_logs/flight_log_model.dart';
import '../db/queries.dart';
import 'shift_model.dart';

class NewShift extends StatefulWidget {
  const NewShift({
    super.key,
    this.givenShiftId = -1, /// to render after a new log is added in FlightLogForm
  });

  final int givenShiftId;

  static const routeName = '/new_shift';

  @override
  NewShiftState createState() {
    return NewShiftState();
  }
}

class NewShiftState extends State<NewShift> {
  String? start;
  String? end;
  int shiftId = -1;

  @override
  dispose() {
    super.dispose();
  }
  // void removeLog(int id) async {
  //   final int count = await removeFlightLogFromDb(id);
  //   bool hasRemoved = count != 0;

  //   print('[removeFlightLogFromDb]: has removed - $hasRemoved');
  // }

  // void updateLog(FlightLogModel log) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => FlightLogForm(log: log)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    void addLog() {
      appState.addToHistory(FlightLogForm.routeName);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
          FlightLogForm(
            shiftId: shiftId == -1 ? widget.givenShiftId : shiftId,
            isNewShift: widget.givenShiftId == -1,
          ),
        ),
      );
    }

    final List<FlightLogModel> logs = appState.newShiftFlightLogs;

    void proceedToHome() {
      appState.resetNewShiftFlightLogs();

      Navigator.popAndPushNamed(
        context,
        '/home',
        arguments: {
          'isInitLoading': false,
        },
      );
    }

    void navigateByBackButton() async {
      appState.removeFromHistory(NewShift.routeName);
      proceedToHome();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            BackButton(
              onPressed: navigateByBackButton,
              style: const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
              ),
            ),
            const Padding(padding: EdgeInsets.all(8)),
            const Text('New Shift'),
          ],
        ),
        // automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Center(
            child: SizedBox(
              width: 296,
              child: Text(
                'Flight Logs',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                ),
                // style
              ),
            ),
          ),
          Flexible(
            child:
              ListView.builder(
                restorationId: 'new_shift_flight_logs',
                itemCount: logs.length,
                itemBuilder: (BuildContext context, int index) {
                  final log = logs[index];

                  return NewShiftFlightLog(log: log, index: index);
                },
              ),
          ),
          TextButton(onPressed: addLog, child: const Text('Add log')),
        ],
      ),
    );
  }
}
