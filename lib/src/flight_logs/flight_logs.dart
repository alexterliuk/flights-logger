import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/settings_view.dart';
import '../app_state.dart';
import '../db/queries.dart';
import '../shifts/shift_model.dart';
import '../shifts/shifts_loading.dart';
import '../utils/date_time/get_start_end_dates.dart';
import './flight_log_model.dart';
import './flight_log.dart';
import '../table_methods/table_methods.dart';
import '../home/home.dart';
import '../shifts/shifts.dart';
import 'flight_logs_header.dart';
import 'utils.dart';

class FlightLogsState extends TableMethods {}

class FlightLogs extends StatelessWidget {
  const FlightLogs({
    super.key,
    this.isAppBarShown = true,
    this.idsForReload = const [],
  });

  final bool isAppBarShown;
  final List<int> idsForReload;

  static const routeName = '/flight_logs';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    appState.updateCurrentPage(FlightLogs.routeName);
    appState.addToHistory(FlightLogs.routeName);

    final List<FlightLogModel> logs = appState.isSingleShiftMode
      ? appState.singleShiftFlightLogs
      : appState.flightLogs;

    var title = 'Flight Logs';
    if (appState.isSingleShiftMode) {
      var dateStr = getStartEndDates(
        (appState.singleShift as ShiftModel).startedAtDateAndTime,
        (appState.singleShift as ShiftModel).endedAtDateAndTime,
      );
      title = '$title, $dateStr';
    }

    void getMoreFlightLogs(int offset) async {
      List<FlightLogModel> moreLogs = await getFlightLogsFromDb(offset: offset, limit: 20);

      if (moreLogs.isNotEmpty) {
        appState.updateFlightLogs(givenLogs: moreLogs);
        appState.update();
      }
    }

    void proceedToShiftsWithReload() {
      String prevRouteName = appState.getPrevRouteFromHistory();

      appState.removeFromHistory(FlightLogs.routeName);

      while(Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      if (prevRouteName == Shifts.routeName) {
        appState.resetShifts();

        if (appState.isSingleShiftMode) {
          appState.resetSingleShiftMode();
        }

        // ADDING UPDATE DOESN'T FIX BECAUSE LOGS ARE ERASED ONLY IN 'ACTIVE' VIEWS
        // BUT IN NOT VISIBLE VIEWS THERE'S STILL OLD STATE OF APP_STATE AND LOGS ARE PRESENT
        // TODO: REWRITE LOGIC, SO THAT LOGS ARE DOWNLOADED BY ID AT THE MOMENT THEY ARE NEEDED
        // (WHEN YOU OPEN SHIFT, APP_STATE.SINGLE_SHIFT_FLIGHT_LOGS AND ...IDS AREN'T NEEDED ANYMORE)
        // ---------- OR: ON OPENING SHIFT (FLIGHT_LOGS), RESET_SINGLE_SHIFT_FLIGHT_LOGS!!!!
        //
        //
        // appState.update();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShiftsLoading(
            fromDate: appState.selectShiftsFromDate,
            toDate: appState.selectShiftsToDate,
          ),
        ));
      } else {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Home(
            isInitLoading: false,
          )),
        );
      }
    }


// // if (navigatorState != null) {
// //   navigatorState
// //     ..pop()
// //     ..pop()
// //     ..pushNamed('/settings');
// // }
//     }

    void onPressBackButton() async {
      // Future.delayed(Duration.zero, () async {
        if (appState.singleShift == null) {
          proceedToShiftsWithReload();
        } else {
          ShiftModel? editedShift = await getShiftFromDb(
            appState.singleShift!.id,
          );

          bool isShiftChanged = hasShiftChanged(
            appState.singleShift as ShiftModel,
            editedShift as ShiftModel,
          );

          if (isShiftChanged) {
            /// when replaceShift called, changes in edited shift are visible
            /// (no appState.resetShifts call is needed)
            appState.replaceShift(editedShift);
          }

          proceedToShiftsWithReload();
        }
      // });
    }

    return ChangeNotifierProvider(
      create: (context) => FlightLogsState(),
      child: Scaffold(
        appBar: isAppBarShown
          ? AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Row(
                children: [
                  BackButton(
                    onPressed: onPressBackButton,
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Text(title),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Navigator.restorablePushNamed(context, SettingsView.routeName);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.abc),
                  onPressed: () {
                    Navigator.restorablePushNamed(context, '/flight_log_form');
                  },
                ),
              ],
            )
          : null,
        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.

        // extendBodyBehindAppBar: true,
        // extendBody: true,

        body: Column(
          children: [
            FlightLogsHeader(isSingleShiftMode: appState.isSingleShiftMode),
            Flexible(
              child: ListView.builder(
                // Providing a restorationId allows the ListView to restore the
                // scroll position when a user leaves and returns to the app after it
                // has been killed while running in the background.
                restorationId: 'flight_logs',
                itemCount: logs.length,
                itemBuilder: (BuildContext context, int index) {
                  final log = logs[index];

                  if (!appState.isSingleShiftMode) {
                    if (index == logs.length - 2) {
                      print('...loading more logs, index $index');
                      getMoreFlightLogs(logs.length);
                    }
                  }

                  return FlightLog(
                    log: log,
                    index: index,
                    isSingleShiftMode: appState.isSingleShiftMode,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
