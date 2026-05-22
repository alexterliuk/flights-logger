import 'package:flutter/material.dart';
import '../flight_logs/flight_log_model.dart';
import '../utils/date_time/get_date_string_without_time.dart';
import '../utils/date_time/get_time.dart';
import '../utils/get_flight_log_distance_kilometers.dart';

List<Widget> getFlightLogMainInfoCells(FlightLogModel log, int index) {
  var countCell = Expanded(
    flex: 1,
    child: Text(
      '${index + 1}',
      textAlign: TextAlign.start,
      style: const TextStyle(height: 2.4, fontSize: 14),
    ),
  );

  var takeoffDateAndTimeCell = Expanded(
    flex: 2,
    child: Text(
      log.takeoffDateAndTime,
      textAlign: TextAlign.start,
      style: const TextStyle(height: 1.4, fontSize: 14),
    ),
  );

  var takeoffTimeCell = Expanded(
    flex: 2,
    child: Text(
      getTime(log.takeoffDateAndTime),
      textAlign: TextAlign.end,
      style: const TextStyle(height: 2.4, fontSize: 14),
    ),
  );

  var landingTimeCell = Expanded(
    flex: 2,
    child: Text(
      getTime(log.landingDateAndTime),
      textAlign: TextAlign.end,
      style: const TextStyle(height: 2.4, fontSize: 14),
    ),
  );

  var distanceCell = Expanded(
    flex: 2,
    child: Text(
      getFlightLogDistanceKilometers(log.distanceMeters),
      textAlign: TextAlign.end,
      style: const TextStyle(height: 2.4, fontSize: 14),
    ),
  );

  var locationCell = Expanded(
    flex: 2,
    child: Text(
      log.location,
      textAlign: TextAlign.end,
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(height: 1.4, fontSize: 14),
    ),
  );

  return [
    countCell,
    takeoffDateAndTimeCell,
    takeoffTimeCell,
    landingTimeCell,
    distanceCell,
    locationCell,
  ];
}

const expandedRowScaler = TextScaler.linear(0.8);

List<Widget> getFlightLogExtraInfoFirstRowCells(FlightLogModel log) {
  var flightTimeCell = Column(children: [
    Row(children: [
      SizedBox(
        width: 96,
        child: Text(
          'Flight Time',
          textScaler: expandedRowScaler,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]),
    Row(children: [
      SizedBox(
        width: 96,
        child: Text(
          '${log.flightTimeMinutes} min',
          textScaler: expandedRowScaler,
          textAlign: TextAlign.start,
        ),
      ),
    ]),
  ]);

  var altitudeCell = Column(children: [
    Row(children: [
      SizedBox(
        width: 72,
        child: Text(
          'Altitude',
          textScaler: expandedRowScaler,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]),
    Row(children: [
      SizedBox(
        width: 72,
        child: Text(
          '${log.altitudeMeters} m',
          textScaler: expandedRowScaler,
          textAlign: TextAlign.start,
        ),
      ),
    ]),
  ]);

  var droneAccum = log.droneAccum.isEmpty ? '' : log.droneAccum;
  var droneAccumChargeLeft =
    log.droneAccumChargeLeft == -1 ? '' : '${log.droneAccumChargeLeft}%';
  var droneAccumRecord = '$droneAccum $droneAccumChargeLeft';

  var batteryCell = Column(children: [
    Row(children: [
      SizedBox(
        width: 80,
        child: Text(
          'Battery',
          textScaler: expandedRowScaler,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]),
    Row(children: [
      SizedBox(
        width: 80,
        child: Text(
          droneAccumRecord,
          textScaler: expandedRowScaler,
          textAlign: TextAlign.start,
        ),
      ),
    ]),
  ]);

  // Important to keep one space string when no data, so that it occupies area,
  // and 'RC Battery' is vertically aligned to 'Flight Time', 'Battery', 'Altitude'
  // (other titles of the first row of expanded block)
  var rcAccumRecord =
    log.rcAccumChargeLeft == -1 ? ' ' : '${log.rcAccumChargeLeft}%';

  var rcBatteryCell = Column(children: [
    Row(children: [
      SizedBox(
        width: 72,
        child: Text(
          'RC Battery',
          textScaler: expandedRowScaler,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]),
    Row(children: [
      SizedBox(
        width: 72,
        child: Text(
          rcAccumRecord,
          textScaler: expandedRowScaler,
          textAlign: TextAlign.start,
        ),
      ),
    ]),
  ]);

  return [
    flightTimeCell,
    altitudeCell,
    batteryCell,
    rcBatteryCell,
  ];
}

List<Widget> getFlightLogExtraInfoDroneNameCell(FlightLogModel log) {
  return [
    SizedBox(
      width: 96,
      child: Text(
        'Drone Name',
        textScaler: expandedRowScaler,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    SizedBox(
      width: 224,
      child: Text(
        log.droneName,
        textScaler: expandedRowScaler,
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ];
}

List<Widget> getFlightLogExtraInfoDroneIdCell(FlightLogModel log) {
  return [
    SizedBox(
      width: 96,
      child: Text(
        'Drone Id',
        textScaler: expandedRowScaler,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    SizedBox(
      width: 224,
      child: Text(
        log.droneId,
        textScaler: expandedRowScaler,
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ];
}

List<Widget> getFlightLogExtraInfoDateCell(FlightLogModel log) {
  return [
    SizedBox(
      width: 96,
      child: Text(
        'Date',
        textScaler: expandedRowScaler,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    SizedBox(
      width: 224,
      child: Text(
        getDateStringWithoutTimeFromDateString(log.takeoffDateAndTime),
        textScaler: expandedRowScaler,
        textAlign: TextAlign.start,
      ),
    ),
  ];
}

List<Widget> getFlightLogExtraInfoNoteCell(FlightLogModel log) {
  return [
    SizedBox(
      width: 96,
      child: Text(
        'Note',
        textScaler: expandedRowScaler,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    SizedBox(
      width: 224,
      child: Text(
        log.note,
        textScaler: expandedRowScaler,
        textAlign: TextAlign.start,
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ];
}
