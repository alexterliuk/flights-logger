import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home.dart';
import '../app_state.dart';
import '../utils/get_flight_log_distance_kilometers.dart';
import '../flight_log_form/flight_log_form.dart';
import '../utils/date_time/get_time.dart';
import './flight_log_model.dart';
import './flight_logs.dart';

class FlightLog extends StatelessWidget {
  const FlightLog({
    super.key,
    required this.log,
    required this.index,
    required this.isSingleShiftMode,
  });

  final FlightLogModel log;
  final int index;
  final bool isSingleShiftMode;

  @override
  Widget build(BuildContext context) {
    var flightLogsState = context.watch<FlightLogsState>();
    var appState = context.watch<MyAppState>();

    edit () {
      flightLogsState.updateEditAndDeleteButtonsView(index, false);
      appState.addToHistory(FlightLogForm.routeName);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FlightLogForm(log: log, shiftId: log.shiftId)),
      );
    }

    remove() async {
      RemovalResult removalResult = await appState.dbRemoveFlightLog(log.id, log.shiftId);

      if (removalResult.isLogRemoved) {
        flightLogsState.updateEditAndDeleteButtonsView(index, false);
        appState.update();
      }

      if (removalResult.isShiftRemoved) {
        appState.resetSingleShiftMode();
        appState.updateShiftsResAfterShiftRemoved(removalResult.removedShiftId);
      }

      if (removalResult.isLogRemoved || removalResult.isShiftRemoved) {
        // if using with `await`, an err in terminal - at this moment widget's state is not stable...
        appState.dbUpdateHome(shouldRefresh: true);
      }

      if (removalResult.isShiftRemoved) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    }

    const collapsibleRowScaler = TextScaler.linear(0.8);

    var droneAccum = log.droneAccum.isEmpty ? '' : log.droneAccum;
    var droneAccumChargeLeft = log.droneAccumChargeLeft == -1 ? '' : '${log.droneAccumChargeLeft}%';
    var droneAccumRecord = '$droneAccum $droneAccumChargeLeft';
    var rcAccumRecord = log.rcAccumChargeLeft == -1 ? '' : '${log.rcAccumChargeLeft}%';

    var gap4 = const SizedBox(width: 4);
    var gap8 = const SizedBox(width: 8);
    var gap12 = const SizedBox(width: 12);

    var countCell = SizedBox(
      width: 40,
      height: 36,
      child: Text(
        '${index + 1}',
        textAlign: TextAlign.start,
        style: const TextStyle(height: 2.4),
      ),
    );

    var dateCell = SizedBox(
      width: 88,
      height: 36,
      child: Text(
        log.takeoffDateAndTime,
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4),
      ),
    );

    var takeoffCell = SizedBox(
      width: 64,
      height: 36,
      child: Text(
        getTime(log.takeoffDateAndTime),
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4),
      ),
    );

    var landingCell = SizedBox(
      width: 64,
      height: 36,
      child: Text(
        getTime(log.landingDateAndTime),
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4),
      ),
    );

    var distanceCell = SizedBox(
      width: 82,
      height: 36,
      child: Text(
        getFlightLogDistanceKilometers(log.distanceMeters),
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4),
      ),
    );

    var locationCell = SizedBox(
      width: 82,
      height: 36,
      child: Text(
        log.location,
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4),
      ),
    );

    var buttonsCell = SizedBox(
      width: 82,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: edit,
            iconSize: 18,
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: remove,
            iconSize: 18,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );

    return Column(
      children: [
        Column(
          children: [
            ListTile(
              title: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          isSingleShiftMode ? countCell : dateCell,
                          gap4,
                          takeoffCell,
                          gap8,
                          landingCell,
                          gap8,
                          isSingleShiftMode ? distanceCell : Container(),
                          isSingleShiftMode ? gap12 : Container(),
                          flightLogsState.areEditAndDeleteButtonsShown(index)
                            ? buttonsCell
                            : isSingleShiftMode ? locationCell : distanceCell,
                        ],
                      ),
                      flightLogsState.isExpanded(log.id)
                        ?
                          Column(
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Row(
                                        children: [
                                          SizedBox(
                                            width: 96,
                                            child: Text(
                                              'Flight time',
                                              textScaler: collapsibleRowScaler,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 96,
                                            child: Text(
                                              '${log.flightTimeMinutes}m',
                                              textScaler: collapsibleRowScaler,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Row(
                                        children: [
                                          SizedBox(
                                            width: 72,
                                            child: Text(
                                              'Altitude ',
                                              textScaler: collapsibleRowScaler,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 72,
                                            child: Text(
                                              '${log.altitudeMeters} m',
                                              textScaler: collapsibleRowScaler,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Row(
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            child: Text(
                                              'Battery',
                                              textScaler: collapsibleRowScaler,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            child: Text(
                                              droneAccumRecord,
                                              textScaler: collapsibleRowScaler,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Row(
                                        children: [
                                          SizedBox(
                                            width: 72,
                                            child: Text(
                                              'RC Battery',
                                              textScaler: collapsibleRowScaler,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 72,
                                            child: Text(
                                              rcAccumRecord,
                                              textScaler: collapsibleRowScaler,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const Padding(padding: EdgeInsetsGeometry.directional(top: 8)),

                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    width: 96,
                                    child: Text(
                                      'Drone Name',
                                      textScaler: collapsibleRowScaler,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 224,
                                    child: Text(
                                      log.droneName,
                                      textScaler: collapsibleRowScaler,
                                    ),
                                  ),
                                ],
                              ),

                              const Padding(padding: EdgeInsetsGeometry.directional(top: 8)),

                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    width: 96,
                                    child: Text(
                                      'Drone Id',
                                      textScaler: collapsibleRowScaler,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 224,
                                    child: Text(
                                      log.droneId,
                                      textScaler: collapsibleRowScaler,
                                    ),
                                  ),
                                ],
                              ),

                              const Padding(padding: EdgeInsetsGeometry.directional(top: 8)),

                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(
                                    width: 96,
                                    child: Text(
                                      'Note',
                                      textScaler: collapsibleRowScaler,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 224,
                                    child: Text(
                                      log.note,
                                      textScaler: collapsibleRowScaler,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          )
                        :
                          Container(),
                    ],
                  ),
                ],
              ),
              selectedTileColor: const Color.fromARGB(255, 75, 44, 126),
              onTap: () {
                flightLogsState.updateExpandingView(log.id, !flightLogsState.isExpanded(log.id));
              },
              onLongPress: () {
                flightLogsState.updateEditAndDeleteButtonsView(index, true);
              },
            ),
          ],
        ),
      ],
    );
  }
}
