import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    this.isOrdinalShown = true,
  });

  final FlightLogModel log;
  final int index;
  final bool isOrdinalShown;

  @override
  Widget build(BuildContext context) {
    var flightLogsState = context.watch<FlightLogsState>();
    var appState = context.watch<MyAppState>();

    print('LOG: started - ${log.takeoffDateAndTime}, ended - ${log.landingDateAndTime}');
    // started - 2024-04-14 00:00, ended - 2024-04-14 01:39

    edit () {
      flightLogsState.updateEditAndDeleteButtonsView(index, false);
      appState.addToHistory(FlightLogForm.routeName);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FlightLogForm(log: log, shiftId: log.shiftId)),
      );
    }

    remove() async {
      bool isRemoved = await appState.dbRemoveFlightLog(log.id, log.shiftId);

      if (isRemoved) {
        flightLogsState.updateEditAndDeleteButtonsView(index, false);
        appState.update();
      }
    }

    const collapsibleRowScaler = TextScaler.linear(0.8);

    var droneAccum = log.droneAccum.isEmpty ? '' : log.droneAccum;
    var droneAccumChargeLeft = log.droneAccumChargeLeft == -1 ? '' : '${log.droneAccumChargeLeft}%';
    var droneAccumRecord = '$droneAccum $droneAccumChargeLeft';
    var rcAccumRecord = log.rcAccumChargeLeft == -1 ? '' : '${log.rcAccumChargeLeft}%';

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
                          isOrdinalShown
                            ? SizedBox(
                                width: 30,
                                height: 36,
                                child: Text(
                                  '${index + 1}.',
                                  style: const TextStyle(height: 2.4),
                                ),
                              )
                            : const SizedBox(width: 30, height: 36),
                          SizedBox(
                            width: 65,
                            height: 36,
                            child: Text(
                              // getTime(log.takeoffDateAndTime),
                              log.id.toString(),
                              style: const TextStyle(height: 2.4),
                            ),
                          ),
                          SizedBox(
                            width: 65,
                            height: 36,
                            child: Text(
                              getTime(log.landingDateAndTime),
                              style: const TextStyle(height: 2.4),
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            height: 36,
                            child: Text(
                              // '${getFlightLogDistanceKilometers(log.distanceMeters)} км',
                              'shId ${log.shiftId}',
                              style: const TextStyle(height: 2.4),
                            ),
                          ),
                          flightLogsState.areEditAndDeleteButtonsShown(index)
                            ?
                              SizedBox(
                                width: 70,
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
                              )
                            :
                              SizedBox(
                                width: 70,
                                height: 36,
                                child: Text(
                                  log.location,
                                  style: const TextStyle(height: 2.4),
                                ),
                              ),
                        ],
                      ),
                      flightLogsState.isExpanded(log.id)
                        ?
                          Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Row(
                                    children: [
                                      SizedBox(
                                        width: 95,
                                        child: Text(
                                          'Flight time',
                                          textScaler: collapsibleRowScaler,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 95,
                                        child: Text(
                                          '${log.flightTimeMinutes} хв',
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
                                        width: 65,
                                        child: Text(
                                          'Altitude ',
                                          textScaler: collapsibleRowScaler,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 65,
                                        child: Text(
                                          '${log.altitudeMeters} м',
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
                                        width: 90,
                                        child: Text(
                                          'Battery',
                                          textScaler: collapsibleRowScaler,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 90,
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
                                        width: 70,
                                        child: Text(
                                          'RC Battery',
                                          textScaler: collapsibleRowScaler,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 70,
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
