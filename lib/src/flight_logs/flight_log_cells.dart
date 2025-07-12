import 'package:flutter/material.dart';

import '../flight_logs/flight_log_model.dart';
import '../utils/date_time/get_date_string_without_time.dart';
import '../utils/date_time/get_time.dart';
import '../utils/get_flight_log_distance_kilometers.dart';

///
///
///
class ExpandedFlightLogRows {
  Widget expandedFirstRow;
  Widget expandedDroneNameRow;
  Widget expandedDroneIdRow;
  Widget expandedDateRow;
  Widget expandedNoteRow;

  ExpandedFlightLogRows({
    this.expandedFirstRow = const SizedBox(),
    this.expandedDroneNameRow = const SizedBox(),
    this.expandedDroneIdRow = const SizedBox(),
    this.expandedDateRow = const SizedBox(),
    this.expandedNoteRow = const SizedBox(),
  });
}

///
/// Get rows of the expanded section of a flight log
///
ExpandedFlightLogRows getExpandedFlightLogRows(FlightLogModel log) {
  var droneAccum =
    log.droneAccum.isEmpty ? '' : log.droneAccum;
  var droneAccumChargeLeft =
    log.droneAccumChargeLeft == -1 ? '' : '${log.droneAccumChargeLeft}%';
  var droneAccumRecord =
    '$droneAccum $droneAccumChargeLeft';
  var rcAccumRecord =
    log.rcAccumChargeLeft == -1 ? '' : '${log.rcAccumChargeLeft}%';

  var expandedFirstRow = getFlexContainer(children: [
    getExpandedFlightLogFirstRowCell(
      name: getRowCell(
        width: 96,
        text: 'Flight Time',
        isBold: true,
        isSmall: true,
      ),
      value: getRowCell(
        width: 96,
        text: '${log.flightTimeMinutes}m',
        isSmall: true,
      ),
    ),
    getExpandedFlightLogFirstRowCell(
      name: getRowCell(
        width: 72,
        text: 'Altitude',
        isBold: true,
        isSmall: true,
      ),
      value: getRowCell(
        width: 72,
        text: '${log.altitudeMeters} m',
        isSmall: true,
      ),
    ),
    getExpandedFlightLogFirstRowCell(
      name: getRowCell(
        width: 80,
        text: 'Battery',
        isBold: true,
        isSmall: true,
      ),
      value: getRowCell(
        width: 80,
        text: droneAccumRecord,
        isSmall: true,
      ),
    ),
    getExpandedFlightLogFirstRowCell(
      name: getRowCell(
        width: 72,
        text: 'RC Battery',
        isBold: true,
        isSmall: true,
      ),
      value: getRowCell(
        width: 72,
        text: rcAccumRecord,
        isSmall: true,
      ),
    ),
  ]);

  var expandedDroneNameRow = getFlexContainer(children: [
    getRowCell(
      width: 96,
      text: 'Drone Name',
      isBold: true,
      isSmall: true,
    ),
    getRowCell(
      width: 224,
      text: log.droneName,
      isSmall: true,
    ),
  ]);

  var expandedDroneIdRow = getFlexContainer(children: [
    getRowCell(
      width: 96,
      text: 'Drone Id',
      isBold: true,
      isSmall: true,
    ),
    getRowCell(
      width: 224,
      text: log.droneId,
      isSmall: true,
    ),
  ]);

  var expandedDateRow = getFlexContainer(children: [
    getRowCell(
      width: 96,
      text: 'Date',
      isBold: true,
      isSmall: true,
    ),
    getRowCell(
      width: 224,
      text: getDateStringWithoutTimeFromDateString(log.takeoffDateAndTime),
      isSmall: true,
    ),
  ]);

  var expandedNoteRow = getFlexContainer(children: [
    getRowCell(
      width: 96,
      text: 'Note',
      isBold: true,
      isSmall: true,
    ),
    getRowCell(
      width: 224,
      text: log.note,
      isSmall: true,
    ),
  ]);

  return ExpandedFlightLogRows(
    expandedFirstRow: expandedFirstRow,
    expandedDroneNameRow: expandedDroneNameRow,
    expandedDroneIdRow: expandedDroneIdRow,
    expandedDateRow: expandedDateRow,
    expandedNoteRow: expandedNoteRow,
  );
}

///
/// Get a cell of the first row in the expanded section of a flight log
///
Widget getExpandedFlightLogFirstRowCell({
  Widget name = const SizedBox(),
  Widget value = const SizedBox(),
}) => Column(children: [
  Row(children: [name]),
  Row(children: [value]),
]);

///
///
///
class FlightLogCells {
  Widget countCell;
  Widget dateCell;
  Widget takeoffCell;
  Widget landingCell;
  Widget distanceCell;
  Widget locationCell;
  Widget buttonsCell;

  FlightLogCells({
    this.countCell = const SizedBox(),
    this.dateCell = const SizedBox(),
    this.takeoffCell = const SizedBox(),
    this.landingCell = const SizedBox(),
    this.distanceCell = const SizedBox(),
    this.locationCell = const SizedBox(),
    this.buttonsCell = const SizedBox(),
  });
}

///
/// Get cells of not expanded view of a flight log
///
FlightLogCells getFlightLogCells(FlightLogModel log, int index) {
  var countCell = getRowCell(
    width: 40,
    height: 36,
    text: '${index + 1}',
    textHeight: 2.4,
  );

  var dateCell = getRowCell(
    width: 88,
    height: 36,
    text: log.takeoffDateAndTime,
    textAlign: TextAlign.end,
    textHeight: 2.4,
  );

  var takeoffCell = getRowCell(
    width: 64,
    height: 36,
    text: getTime(log.takeoffDateAndTime),
    textAlign: TextAlign.end,
    textHeight: 2.4,
  );

  var landingCell = getRowCell(
    width: 64,
    height: 36,
    text: getTime(log.landingDateAndTime),
    textAlign: TextAlign.end,
    textHeight: 2.4,
  );

  var distanceCell = getRowCell(
    width: 82,
    height: 36,
    text: getFlightLogDistanceKilometers(log.distanceMeters),
    textAlign: TextAlign.end,
    textHeight: 2.4,
  );

  var locationCell = getRowCell(
    width: 82,
    height: 36,
    text: log.location,
    textAlign: TextAlign.end,
    textHeight: 2.4,
  );

  return FlightLogCells(
    countCell: countCell,
    dateCell: dateCell,
    takeoffCell: takeoffCell,
    landingCell: landingCell,
    distanceCell: distanceCell,
    locationCell: locationCell,
  );
}

///
/// Get flex container
///
Widget getFlexContainer({List<Widget> children = const [] }) => Flex(
  direction: Axis.horizontal,
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: children,
);

const expandedRowScaler = TextScaler.linear(0.8);

///
/// Get row cell
///
Widget getRowCell({
  double? width,
  double? height,
  String text = '',
  bool isBold = false,
  textAlign = TextAlign.start,
  double? textHeight,
  bool isSmall = false,
}) =>
    SizedBox(
      width: width,
      height: height,
      child: Text(
        text,
        textScaler: isSmall ? expandedRowScaler : null,
        textAlign: textAlign,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          height: textHeight,
        ),
      ),
    );
