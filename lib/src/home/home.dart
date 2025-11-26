import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../db/test_data.dart';
import '../flight_logs/flight_log_model.dart';
import '../settings/settings_view.dart';
import '../shifts/start_new_shift.dart';
import '../db/queries.dart';
import '../app_state.dart';
import '../flight_logs/last_flight.dart';
import '../flight_logs/show_all_flights.dart';
import '../shifts/select_shift.dart';
import '../shifts/show_all_shifts.dart';
import '../calculation/calculate_data.dart';
import '../upload_data/upload_data_button.dart';
import 'top_numbers.dart';
import 'home_model.dart';

class Home extends StatefulWidget {
  final bool isInitLoading;

  const Home({
    super.key,
    this.isInitLoading = true,
  });

  static const routeName = '/home_page';

  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  bool hasLoaded = false;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    appState.updateCurrentPage(Home.routeName);
    appState.addToHistory(Home.routeName);

    bool isInit = widget.isInitLoading && !hasLoaded;

/// NB ABOUT HOME
/// - initial load is made by async (runApp -> Home with no args)
/// - by back button always reload home
/// - when home is being reloaded all changes have been already applied (home will get them simply from appState)
/// - TODO: add route /home to app, by back button call /home (initial load from runApp will be made in default case)
///

    if (isInit) {
      Future.delayed(const Duration(milliseconds: 300), () async {
        (() async {
          HomeModel homeData = await getHomeFromDb();

          if (homeData.lastFlightLogId != -1) {
            FlightLogModel? lastLog = await getFlightLogFromDb(homeData.lastFlightLogId);

            if (lastLog is FlightLogModel) {
              appState.updateLastFlightLog(lastLog);

              if (appState.flightLogs.isNotEmpty) {
                // reset logs, so that if last log is edited from Home page, and got
                // earlier date, and thus becomes not last log, Flight Logs page will show
                // correct order of logs (not last log won't be on top of logs in the table)
                appState.resetFlightLogs();
              }
            }
          }

          bool isLastShiftIdChanged = appState.lastShiftId != homeData.lastShiftId;
          bool isTopFlightTimeChanged = appState.topFlightTimeMinutes != homeData.topFlightTimeMinutes;
          bool isTopDistanceChanged = appState.topDistanceMeters != homeData.topDistanceMeters;
          bool isTopAltitudeChanged = appState.topAltitudeMeters != homeData.topAltitudeMeters;

          if (isLastShiftIdChanged) {
            appState.updateLastShiftId(homeData.lastShiftId);
          }

          if (isTopFlightTimeChanged) {
            appState.updateTopFlightTime(homeData.topFlightTimeMinutes);
          }

          if (isTopDistanceChanged) {
            appState.updateTopDistance(homeData.topDistanceMeters);
          }

          if (isTopAltitudeChanged) {
            appState.updateTopAltitude(homeData.topAltitudeMeters);
          }

          setState(() {
            hasLoaded = true;
          });
        })();
      });

      /// uncomment when adding test data needed,
      /// after test data added, comment it again and reload app,
      /// so that correct top numbers shown on home page
      // Future.delayed(const Duration(milliseconds: 3000), () async {
      //   (() async {
      //     print('creating dummy data...');
      //     await createDummyData();
      //     print('creating dummy data has finished');
      //   })();
      // });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Route'),
        automaticallyImplyLeading: false, // needed for not showing back button
        // title: Text(AppLocalizations.of(context)!.helloWorld),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Open settings',
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(height: 12),
          isInit ? const CircularProgressIndicator() : Container(),
          TopNumbers(
            topFlightTimeMinutes: appState.topFlightTimeMinutes,
            topDistanceMeters: appState.topDistanceMeters,
            topAltitudeMeters: appState.topAltitudeMeters,
          ),
          Container(height: 12),
          // LastFlight(log: appState.lastFlightLog),
          LastFlight(),
          // // ?EditFlightBtn,
          const SelectShift(),
          const ShowAllShifts(),
          const ShowAllFlights(),
          const StartNewShift(),
          const CalculateData(),
          // const DefaultFilesUpload(),
          const UploadDataButton(),
          // const Flexible(
          //   child: FlightLogs(isOrdinalShown: false),
          // ),

          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       // Add the following code
          //       Localizations.override(
          //         context: context,
          //         locale: const Locale('en'),
          //         // Using a Builder to get the correct BuildContext.
          //         // Alternatively, you can create a new widget and Localizations.override
          //         // will pass the updated BuildContext to the new widget.
          //         child: Builder(
          //           builder: (context) {
          //             // A toy example for an internationalized Material widget.
          //             return CalendarDatePicker(
          //               initialDate: DateTime.now(),
          //               firstDate: DateTime(1900),
          //               lastDate: DateTime(2100),
          //               onDateChanged: (value) {},
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

        ],
      ),
    );
  }
}
