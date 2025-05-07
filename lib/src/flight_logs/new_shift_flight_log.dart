import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../flight_log_form/flight_log_form.dart';
import '../app_state.dart';
import '../utils/date_time/get_time.dart';
import 'flight_log_model.dart';

class NewShiftFlightLog extends StatelessWidget {
  final FlightLogModel log;
  final int index;

  const NewShiftFlightLog({
    super.key,
    required this.log,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    void edit() {
      appState.addToHistory(FlightLogForm.routeName);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FlightLogForm(log: log, shiftId: log.shiftId)),
      );
    }

    return Center(
      child: SizedBox(
        width: 296,
        child: Column(
          children: [
            // Container(height: 6),
            Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 26,
                  child: Text(
                    '${index + 1}.',
                    style: const TextStyle(height: 2.4, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 266,
                  height: 26,
                  child: Text(
                    '${getTime(log.takeoffDateAndTime)} - ${getTime(log.landingDateAndTime)}',
                    style: const TextStyle(height: 2.4),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 30, height: 26),
                SizedBox(
                  width: 266,
                  height: 26,
                  child: Text(
                    'Flight time - ${log.flightTimeMinutes}m',
                    style: const TextStyle(height: 2.4),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 30, height: 26),
                SizedBox(
                  width: 133,
                  height: 26,
                  child: Text(
                    'Distance - ${log.distanceMeters} m',
                    style: const TextStyle(height: 2.4),
                  ),
                ),
                SizedBox(
                  width: 133,
                  height: 26,
                  child: Text(
                    'Altitude - ${log.altitudeMeters} m',
                    style: const TextStyle(height: 2.4),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 30, height: 26),
                SizedBox(
                  width: 266,
                  height: 26,
                  child: Text(
                    'Location - ${log.location}',
                    style: const TextStyle(height: 2.4),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 30, height: 26),
                SizedBox(
                  width: 156,
                  height: 26,
                  child: Text(
                    'Drone accum - ${log.droneAccum} ${log.droneAccumChargeLeft}',
                    style: const TextStyle(height: 2.4),
                  ),
                ),
                SizedBox(
                  width: 110,
                  height: 26,
                  child: Text(
                    'RC - ${log.rcAccumChargeLeft}',
                    style: const TextStyle(height: 2.4),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 240, height: 26),
                TextButton(onPressed: edit, child: const Text('Edit')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
