// // import 'package:flutter/material.dart';

// import 'app_state_init_data_model.dart';
// import 'db/queries.dart';
// import 'flight_logs/flight_log_model.dart';
// import 'home/home_model.dart';

// class AppStateInitData {
//   final AppStateInitDataModel _data = AppStateInitDataModel(
//     lastFlightLog: FlightLogModel(
//       id: -1,
//       shiftId: -1,
//     ),
//   );

//   AppStateInitDataModel getData() => _data;

//   Future<void> loadInitData() async {
//     print('[AppStateInitData] loadInitData start');

//     HomeModel homeData = await getHomeFromDb();
//     FlightLogModel? log = await getFlightLogFromDb(homeData.lastFlightLogId);
//     List<FlightLogModel> lastFlightLogs = await getFlightLogsFromDb(offset: 0, limit: 20);
//     // List<FlightLogModel> lastFlightLogs = await getFlightLogsFromDb();

//     _data.topFlightTimeMinutes = homeData.topFlightTimeMinutes;
//     _data.topDistanceMeters = homeData.topDistanceMeters;
//     _data.topAltitudeMeters = homeData.topAltitudeMeters;
//     _data.lastShiftId = homeData.lastShiftId;
//     _data.lastFlightLogs = lastFlightLogs;

//     if (log != null) {
//       _data.lastFlightLog = log;
//     }

//     print('[AppStateInitData] loadInitData done');
//   }
// }
