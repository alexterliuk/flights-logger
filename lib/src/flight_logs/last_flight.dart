import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../flight_log_form/flight_log_form.dart';
import '../flight_logs/flight_logs_header.dart';
import '../utils/date_time/get_start_end_dates.dart';
import '../utils/date_time/get_time.dart';
import '../utils/get_flight_log_distance_kilometers.dart';
import 'flight_log_model.dart';

class LastFlight extends StatelessWidget {
  const LastFlight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    final FlightLogModel log = appState.lastFlightLog;
    bool isEditButtonHidden = log.shiftId == -1;

    String logDate = getStartEndDates(
      log.takeoffDateAndTime,
      log.landingDateAndTime,
      withYear: true,
    );

    void edit() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
          FlightLogForm(log: log, shiftId: log.shiftId),
        ),
      );
    }

    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 296,
              child: Text(
                'Last flight${' - $logDate'}',
                textScaler: const TextScaler.linear(1.4),
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
        // log == null
        //   ? Container()
        //   : Flex(
        //       direction: Axis.horizontal,
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: [
        //         SizedBox(
        //           width: 296,
        //           child: Text(
        //             getStartEndDates(log!.landingDateAndTime, log!.landingDateAndTime, withYear: true),
        //             textScaler: const TextScaler.linear(1.4),
        //           ),
        //         ),
        //       ],
        //     ),
        Container(height: 6),
        const FlightLogsHeader(isLastFlightMode: true),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 64,
                  height: 36,
                  child: Text(
                    getTime(log.takeoffDateAndTime),
                    textAlign: TextAlign.end,
                    style: const TextStyle(height: 2.4),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 64,
                  height: 36,
                  child: Text(
                    getTime(log.landingDateAndTime),
                    textAlign: TextAlign.end,
                    style: const TextStyle(height: 2.4),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  height: 36,
                  child: Text(
                    getFlightLogDistanceKilometers(log.distanceMeters),
                    textAlign: TextAlign.end,
                    style: const TextStyle(height: 2.4),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 82,
                  height: 36,
                  child: Text(
                    log.location.isEmpty ? '-' : log.location,
                    textAlign: TextAlign.end,
                    style: const TextStyle(height: 2.4),
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ],
        ),
        isEditButtonHidden
          ? Container()
          : TextButton(onPressed: edit, child: const Text('Edit')),
      ],
    );
  }
}
