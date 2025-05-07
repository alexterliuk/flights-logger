import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          // ?EditFlightBtn,
          const SelectShift(),
          const ShowAllShifts(),
          const ShowAllFlights(),
          const StartNewShift(),
          // const Flexible(
          //   child: FlightLogs(isOrdinalShown: false),
          // ),
        ],
      ),
    );
  }
}
