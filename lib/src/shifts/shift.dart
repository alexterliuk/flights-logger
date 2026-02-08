import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../flight_logs/flight_logs_loading.dart';
import 'shift_section_additional_info.dart';
import 'shift_section_main_info.dart';
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

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: ListTile(
        // minVerticalPadding: 6,
        title: Column(
          children: [
            ShiftsSectionMainInfo(
              shift: shift,
              index: index,
              isEditButtonShown: shiftsState.isButtonsBlockShown(index),
              edit: edit
            ),
            ShiftsSectionAdditionalInfo(
              shift: shift,
              isExpanded: shiftsState.isExpanded(shift.id),
            ),
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
