import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../flight_logs/flight_logs_loading.dart';
import '../utils/get_total_time.dart';
import 'shift_model.dart';
import 'shifts.dart';

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
      shiftsState.updateButtonsView(index, false);

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

    /// --- PRIMARY INFO CELLS ---
    var countCell = Expanded(
      flex: 3,
      child: Text(
        '${index + 1}',
        textAlign: TextAlign.start,
        style: const TextStyle(height: 2.4),
      ),
    );

    var shiftStartedAtCell = Expanded(
      flex: 2,
      child: Text(
        shift.startedAtDateAndTime.isEmpty
          ? 'none'
          : shift.startedAtDateAndTime.substring(0, 10),
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4),
      ),
    );

    var shiftEndedAtCell = Expanded(
      flex: 2,
      child: Text(
        shift.endedAtDateAndTime.isEmpty
          ? 'none'
          : shift.endedAtDateAndTime.substring(0, 10),
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4),
      ),
    );

    var shiftFlightsQtyCell = Expanded(
      flex: 2,
      child: Text(
        '${shift.flightsQty}',
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4),
      ),
    );

    var shiftTimeTotal = Expanded(
      flex: 2,
      child: SizedBox(
        width: 70,
        height: 38,
        child: Text(
          getTotalTime(shift.timeTotalMinutes + 600),
          textAlign: TextAlign.end,
          style: const TextStyle(height: 2.4),
        ),
      ),
    );

    var editButtonCell = Expanded(
      flex: 2,
      child: SizedBox(
        width: 70,
        height: 38,
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
          ],
        ),
      ),
    );

    /// --- ADDITIONAL INFO CELLS ---
    var longestFlightTimeCell = Row(
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
          child: Text('${shift.longestFlightTimeMinutes} m'),
        ),
      ],
    );

    var longestDistanceCell = Row(
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
          child: Text('${shift.longestDistanceMeters} m'),
        ),
      ],
    );

    var highestAltitudeCell = Row(
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
          child: Text('${shift.highestAltitudeMeters} m'),
        ),
      ],
    );

    var additionalInfo = Column(
      children: [
        longestFlightTimeCell,
        longestDistanceCell,
        highestAltitudeCell,
      ],
    );

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: ListTile(
        // minVerticalPadding: 6,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                countCell,
                shiftStartedAtCell,
                shiftEndedAtCell,
                shiftFlightsQtyCell,
                shiftsState.isButtonsBlockShown(index)
                  ? editButtonCell
                  : shiftTimeTotal,
              ],
            ),
            shiftsState.isExpanded(shift.id) ? additionalInfo : Container(),
          ],
        ),
        selectedTileColor: const Color.fromARGB(255, 75, 44, 126),
        onTap: () {
          shiftsState.updateExpandingView(shift.id, !shiftsState.isExpanded(shift.id));
        },
        onLongPress: () {
          shiftsState.updateButtonsView(index, true);
        },
      ),
    );
  }
}
