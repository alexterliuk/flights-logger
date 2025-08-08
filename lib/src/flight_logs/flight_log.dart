import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../flight_log_form/flight_log_form.dart';
import '../shifts/shifts_loading.dart';
import 'flight_log_model.dart';
import 'flight_logs.dart';
import 'flight_log_cells.dart';

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
        MaterialPageRoute(builder: (context) =>
          FlightLogForm(log: log, shiftId: log.shiftId)),
      );
    }

    remove() async {
      RemovalResult removalResult =
        await appState.dbRemoveFlightLog(log.id, log.shiftId);

      if (removalResult.isLogRemoved) {
        flightLogsState.updateEditAndDeleteButtonsView(index, false);
        appState.update();
      }

      if (removalResult.isShiftRemoved) {
        appState.updateShiftsResAfterShiftRemoved(removalResult.removedShiftId);
      }

      if (removalResult.isShiftRemoved && appState.isSingleShiftMode) {
        appState.resetSingleShiftMode();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ShiftsLoading()),
        );
      }
    }

    final gap4 = const SizedBox(width: 4);
    final gap8 = const SizedBox(width: 8);
    final gap12 = const SizedBox(width: 12);
    final padding8 = const Padding(
      padding: EdgeInsetsGeometry.directional(top: 8),
    );

    final buttonsCell = SizedBox(
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

    final ExpandedFlightLogRows(
      :expandedFirstRow,
      :expandedDroneNameRow,
      :expandedDroneIdRow,
      :expandedDateRow,
      :expandedNoteRow,
    ) = getExpandedFlightLogRows(log);

    final FlightLogCells(
      :countCell,
      :dateCell,
      :takeoffCell,
      :landingCell,
      :distanceCell,
      :locationCell,
    ) = getFlightLogCells(log, index);

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
                              expandedFirstRow,
                              padding8,
                              expandedDroneNameRow,
                              padding8,
                              expandedDroneIdRow,
                              padding8,
                              isSingleShiftMode ? expandedDateRow : Container(),
                              isSingleShiftMode ? padding8 : Container(),
                              expandedNoteRow,
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
