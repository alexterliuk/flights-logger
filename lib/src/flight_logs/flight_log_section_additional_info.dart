import 'package:flutter/material.dart';
import '../utils/date_time/get_time.dart';
import '../utils/get_flight_log_distance_kilometers.dart';
import 'flight_log_model.dart';
import 'flight_logs.dart';

class FlightLogSectionAdditionalInfo extends StatelessWidget {
  const FlightLogSectionAdditionalInfo({
    super.key,
    required this.log,
    required this.index,
    required this.isSingleShiftMode,
    required this.flightLogsState,
  });

  final FlightLogModel log;
  final int index;
  final bool isSingleShiftMode;
  final FlightLogsState flightLogsState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            isSingleShiftMode
                ? '${index + 1}'
                : log.takeoffDateAndTime,
            textAlign: TextAlign.start,
            style: const TextStyle(height: 2.4),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            getTime(log.takeoffDateAndTime),
            textAlign: TextAlign.end,
            style: const TextStyle(height: 2.4),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            getTime(log.landingDateAndTime),
            textAlign: TextAlign.end,
            style: const TextStyle(height: 2.4),
          ),
        ),
        isSingleShiftMode
            ? Expanded(
          flex: 2,
          child: Text(
            getFlightLogDistanceKilometers(log.distanceMeters),
            textAlign: TextAlign.end,
            style: const TextStyle(height: 2.4),
          ),
        )
            : Container(),
        flightLogsState.isButtonsBlockShown(index)
            ? Container()
            : Expanded(
          flex: 2,
          child: Text(
            isSingleShiftMode
                ? log.location
                : getFlightLogDistanceKilometers(log.distanceMeters),
            textAlign: TextAlign.end,
            style: const TextStyle(height: 2.4),
          ),
        ),
      ],
    );
  }
}
