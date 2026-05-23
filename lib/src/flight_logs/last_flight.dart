import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../flight_log_form/flight_log_form.dart';
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

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0x332D3E50),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Last flight${' - $logDate'}',
                textScaler: const TextScaler.linear(1.4),
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              isEditButtonHidden
                ? Container()
                : IconButton(
                    onPressed: edit,
                    icon: const Icon(Icons.edit, size: 16),
                  ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getLastLogItem('Takeoff', getTime(log.takeoffDateAndTime)),
              getLastLogItem('Landing', getTime(log.landingDateAndTime)),
              getLastLogItem(
                'Distance',
                getFlightLogDistanceKilometers(log.distanceMeters),
              ),
              getLastLogLocationItem(
                'Location',
                'Once upon a time there was a weird thing',
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget getLastLogItem(String label, String value) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(value),
      ],
    ),
  );
}

Widget getLastLogLocationItem(String label, String value) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
          child: Text(
            value,
            maxLines: 1,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        // SizedBox(
        //   width: 40,
        //   child: Text(
        //     value,
        //     maxLines: 1,
        //     style: const TextStyle(
        //       overflow: TextOverflow.ellipsis,
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}
