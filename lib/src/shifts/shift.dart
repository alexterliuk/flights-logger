import 'package:flights_logger/src/flight_logs/flight_logs_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../app_state.dart';
import '../db/queries.dart';
import '../utils/get_shift_total_time.dart';
import './shift_model.dart';
import './shifts.dart';

class Shift extends StatelessWidget {
  const Shift({
    super.key,
    required this.shift,
    required this.index,
  });

  final ShiftModel shift;
  final int index;

  @override
  Widget build(BuildContext context) {
    var shiftsState = context.watch<ShiftsState>();
    var appState = context.watch<MyAppState>();

    edit () {
      shiftsState.updateEditAndDeleteButtonsView(index, false);

      if (shiftsState.isExpanded(shift.id)) {
        shiftsState.updateExpandingView(shift.id, false);
      }

      // clear logs from previous shift in singleShiftFlightLogs
      // (though you clear logs on exiting of FlightLogs (in proceedToShiftsWithReload), it doesn't work
      // in all cases because changes in appState aren't applied to already downloaded shifts in ListView.builder
      // which are hidden at the moment; that's why you need to clear logs when opening a shift's logs)  
      appState.resetSingleShiftMode();
      appState.setSingleShiftMode(shift);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
          FlightLogsLoading(isLoadByIds: true, ids: shift.logIds)),
      );
    }

    remove() async {
      bool isRemoved = await appState.dbRemoveShift(shift.id);

      if (isRemoved) {
        shiftsState.updateEditAndDeleteButtonsView(index, false);
        /// TODO (maybe old, not needed now): isExpanded is not enough because if next row is also expanded, then
        /// it closes it and expands next one; I need to add id to shiftsState
        // if (shiftsState.isExpanded(shift.id)) {
        //   shiftsState.updateExpandingView(shift.id, false);
        // }
        shiftsState.removeExpandingRecord(shift.id);

        int shiftsTotalCount = await getShiftsTotalCountFromDb();
        appState.shiftsRes.totalCount = shiftsTotalCount;
        appState.update();
      }
    }

    return Column(
      children: [
        Column(
          children: [
            ListTile(
              // minVerticalPadding: 6,
              title: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 36,
                            child: Text(
                              '${index + 1}',
                              textAlign: TextAlign.start,
                              style: const TextStyle(height: 2.4),
                            ),
                          ),
                          const SizedBox(width: 4),

                          SizedBox(
                            width: 88,
                            height: 36,
                            child: Text(
                              shift.startedAtDateAndTime.isEmpty ? 'none' : shift.startedAtDateAndTime.substring(0, 10),
                              textAlign: TextAlign.end,
                              style: const TextStyle(height: 2.4),
                            ),
                          ),
                          const SizedBox(width: 8),

                          SizedBox(
                            width: 88,
                            height: 36,
                            child: Text(
                              shift.endedAtDateAndTime.isEmpty ? 'none' : shift.endedAtDateAndTime.substring(0, 10),
                              textAlign: TextAlign.end,
                              style: const TextStyle(height: 2.4),
                            ),
                          ),
                          const SizedBox(width: 8),

                          SizedBox(
                            width: 48,
                            height: 36,
                            child: Text(
                              '${shift.flightsQty}',
                              textAlign: TextAlign.end,
                              style: const TextStyle(height: 2.4),
                            ),
                          ),
                          const SizedBox(width: 8),

                          shiftsState.areEditAndDeleteButtonsShown(index)
                            ?
                              SizedBox(
                                width: 70,
                                height: 36,
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

                                    // PointerInterceptor(
                                    //   child:
                                    //     IconButton(
                                    //       icon: const Icon(Icons.edit),
                                    //       onPressed: edit,
                                    //       iconSize: 16,
                                    //       visualDensity: VisualDensity.compact,
                                    //     ),
                                    // ),
                                    // PointerInterceptor(
                                    //   child:
                                    //     IconButton(
                                    //       icon: const Icon(Icons.delete),
                                    //       onPressed: () {},
                                    //       iconSize: 16,
                                    //       visualDensity: VisualDensity.compact,
                                    //     ),
                                    // ),
                                  ],
                                ),
                              )
                            :
                              SizedBox(
                                width: 70,
                                height: 36,
                                child: Text(
                                  getShiftTotalTime(shift.timeTotalMinutes),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(height: 2.4),
                                ),
                              ),
                        ],
                      ),
                      shiftsState.isExpanded(shift.id)
                        ?
                          Flex(
                            direction: Axis.vertical,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 48),
                                  const SizedBox(
                                    width: 180,
                                    child: Text(
                                      'Longest flight time: ',
                                      style: TextStyle(fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 140,
                                    child: Text(
                                      '${shift.longestFlightTimeMinutes} m',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 48),
                                  const SizedBox(
                                    width: 180,
                                    child: Text(
                                      'Longest distance: ',
                                      style: TextStyle(fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 140,
                                    child: Text(
                                      '${shift.longestDistanceMeters} m',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(width: 48),
                                  const SizedBox(
                                    width: 180,
                                    child: Text(
                                      'Highest altitude: ',
                                      style: TextStyle(fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 140,
                                    child: Text(
                                      '${shift.highestAltitudeMeters} m',
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
                shiftsState.updateExpandingView(shift.id, !shiftsState.isExpanded(shift.id));
              },
              onLongPress: () {
                shiftsState.updateEditAndDeleteButtonsView(index, true);
              },
            ),
          ],
        ),
      ],
    );
  }
}
