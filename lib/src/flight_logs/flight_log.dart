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
      flightLogsState.updateButtonsView(index, false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
          FlightLogForm(log: log, shiftId: log.shiftId)),
      );
    }

    navigateToShifts () {
      while(Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ShiftsLoading()),
      );
    }

    remove() async {
      RemovalResult removalResult =
        await appState.dbRemoveFlightLog(log.id, log.shiftId);

      if (removalResult.isLogRemoved) {
        flightLogsState.updateButtonsView(index, false);
        appState.update();
      }

      if (removalResult.isShiftRemoved) {
        appState.updateShiftsResAfterShiftRemoved(removalResult.removedShiftId);
      }

      if (removalResult.isShiftRemoved && appState.isSingleShiftMode) {
        appState.resetSingleShiftMode();
        appState.removeFromHistory(FlightLogs.routeName);

        navigateToShifts();
      }
    }

    // final gap4 = const SizedBox(width: 4);
    // final gap8 = const SizedBox(width: 8);
    // final gap12 = const SizedBox(width: 12);
    // final padding8 = const Padding(
    //   padding: EdgeInsetsGeometry.directional(top: 8),
    // );

    var mainInfoCells = getFlightLogMainInfoCells(log, index);
    var countCell = mainInfoCells.first;
    var takeoffDateAndTimeCell = mainInfoCells.elementAt(1);
    var takeoffTimeCell = mainInfoCells.elementAt(2);
    var landingTimeCell = mainInfoCells.elementAt(3);
    var distanceCell = mainInfoCells.elementAt(4);
    var locationCell = mainInfoCells.elementAt(5);

    var buttonsCell = Expanded(
      flex: 2,
      child: SizedBox(
        width: 82,
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.end,
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
      ),
    );

    var extraInfoFirstRowCells = getFlightLogExtraInfoFirstRowCells(log);
    var flightTimeCell = extraInfoFirstRowCells.first;
    var altitudeCell = extraInfoFirstRowCells.elementAt(1);
    var batteryCell = extraInfoFirstRowCells.elementAt(2);
    var rcBatteryCell = extraInfoFirstRowCells.elementAt(3);

    var droneNameCell = getFlightLogExtraInfoDroneNameCell(log);
    var droneIdCell = getFlightLogExtraInfoDroneIdCell(log);
    var dateCell = getFlightLogExtraInfoDateCell(log);
    var noteCell = getFlightLogExtraInfoNoteCell(log);

    var extraInfo = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            flightTimeCell,
            altitudeCell,
            batteryCell,
            rcBatteryCell,
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: droneNameCell,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: droneIdCell,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: dateCell,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: noteCell,
        ),
      ],
    );

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: ListTile(
        title: Column(
          children: [
            Row(
              children: [
                isSingleShiftMode ? countCell : takeoffDateAndTimeCell,
                takeoffTimeCell,
                landingTimeCell,
                isSingleShiftMode ? distanceCell : Container(),
                flightLogsState.isButtonsBlockShown(index)
                  ? buttonsCell
                  : isSingleShiftMode ? locationCell : distanceCell,
              ],
            ),
            flightLogsState.isExpanded(log.id) ? extraInfo : Container(),
          ],
        ),
        selectedTileColor: const Color.fromARGB(255, 75, 44, 126),
        onTap: () {
          flightLogsState.updateExpandingView(log.id, !flightLogsState.isExpanded(log.id));
        },
        onLongPress: () {
          flightLogsState.updateButtonsView(index, true);
        },
      ),
    );
  }
}
