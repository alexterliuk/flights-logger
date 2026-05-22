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
      flex: 1,
      child: Text(
        '${index + 1}',
        textAlign: TextAlign.start,
        style: const TextStyle(height: 2.4, fontSize: 14),
      ),
    );

    var shiftStartedAtCell = Expanded(
      flex: 2,
      child: Text(
        shift.startedAtDateAndTime.isEmpty
          ? 'none'
          : shift.startedAtDateAndTime.substring(0, 10),
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4, fontSize: 14),
      ),
    );

    var shiftEndedAtCell = Expanded(
      flex: 2,
      child: Text(
        shift.endedAtDateAndTime.isEmpty
          ? 'none'
          : shift.endedAtDateAndTime.substring(0, 10),
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4, fontSize: 14),
      ),
    );

    var gap8 = Expanded(
      flex: 0,
      child: const SizedBox(width: 8),
    );

    var shiftFlightsQtyCell = Expanded(
      flex: 2,
      child: Text(
        '${shift.flightsQty}',
        textAlign: TextAlign.end,
        style: const TextStyle(height: 2.4, fontSize: 14),
      ),
    );

    var shiftTimeTotal = Expanded(
      flex: 2,
      child: SizedBox(
        width: 70,
        height: 38,
        child: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            getTotalTime(shift.timeTotalMinutes + 600),
            textAlign: TextAlign.end,
            style: const TextStyle(height: 2.4, fontSize: 14),
          ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: const SizedBox()),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              SizedBox(
                width: 160,
                child: const Text(
                  'Longest flight time:',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Text(
                '${shift.longestFlightTimeMinutes} min',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );

    var longestDistanceCell = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: const SizedBox()),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              SizedBox(
                width: 160,
                child: const Text(
                  'Longest distance:',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Text(
                '${shift.longestDistanceMeters} m',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );

    var highestAltitudeCell = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: const SizedBox()),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              SizedBox(
                width: 160,
                child: const Text(
                  'Highest altitude:',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Text(
                '${shift.highestAltitudeMeters} m',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
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

    return ListTile(
      // minVerticalPadding: 6,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              countCell,
              shiftStartedAtCell,
              gap8,
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
    );
  }
}
