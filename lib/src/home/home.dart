import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../settings/settings_view.dart';
import '../shifts/start_new_shift.dart';
import '../db/queries.dart';
import '../app_state.dart';
import '../flight_logs/last_flight.dart';
import '../flight_logs/show_all_flights.dart';
import '../shifts/select_shift.dart';
import '../shifts/show_all_shifts.dart';
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
          /// =================== THIS WORKS - UPDATES TOP NUMBERS ==================
          HomeModel homeData = await getHomeFromDb();
          // HomeModel homeData = HomeModel();
          bool isTopFlightTimeChanged = appState.topFlightTimeMinutes != homeData.topFlightTimeMinutes;
          bool isTopDistanceChanged = appState.topDistanceMeters != homeData.topDistanceMeters;
          bool isTopAltitudeChanged = appState.topAltitudeMeters != homeData.topAltitudeMeters;

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
            appState.addToHistory(Home.routeName);
            hasLoaded = true;
          });
        })();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Route'),
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
          const LastFlight(),
          // // ?EditFlightBtn,
          const SelectShift(),
          const ShowAllShifts(),
          const ShowAllFlights(),
          const StartNewShift(),
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
