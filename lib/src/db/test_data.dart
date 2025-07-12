import '../flight_logs/flight_log_model.dart';
import '../home/home_model.dart';
import '../shifts/shift_model.dart';
import '../utils/date_time/is_first_date_and_time_earlier.dart';
import '../utils/date_time/is_first_date_and_time_later.dart';
import 'queries.dart';

const logsData = <List>[
  ['Autel Evo Max 4T', '505', '2024-07-20 23:48', '2024-07-20 23:59', 11, 6373, 123, '', '', 0, 0, 1, 'Some notes'],
  ['Autel Evo Max 4T', '505', '2024-07-21 03:48', '2024-07-21 03:59', 11, 7654, 123, '', '', 0, 0, 1, ''],
  ['Autel Evo Max 4T', '505', '2024-07-21 04:41', '2024-07-21 05:03', 22, 3245, 123, '', '', 0, 0, 1, ''],
  ['Autel Evo Max 4T', '505', '2024-07-21 06:13', '2024-07-21 06:17', 4, 1234, 123, 'somewhere', 'RTY7', 23, 17, 1, 'The keymap settings in Android Studio let you choose from a list of preset options or create a custom keymap. To open the keymap settings, choose File > Settings (on macOS, Android Studio > Preferences) and navigate to the Keymap pane.'],
  ['Autel Evo Max 4T', '505', '2024-07-21 10:04', '2024-07-21 10:17', 13, 9876, 123, '', '', 0, 0, 1, ''],
  ['DJI Mavic 3T', '553', '2024-07-21 10:27', '2024-07-21 10:33', 6, 10984, 96, '', '', 0, 0, 1, ''],
  ['DJI Mavic 3T', '553', '2024-07-21 10:41', '2024-07-21 10:58', 17, 2345, 95, '', '', 0, 0, 1, ''],
  ['DJI Mavic 3T', '553', '2024-07-21 16:13', '2024-07-21 16:21', 8, 9876, 178, '', '', 0, 0, 1, ''],
  ['DJI Mavic 3T', '553', '2024-07-21 16:57', '2024-07-21 17:09', 12, 1001, 178, '', '', 0, 0, 1, ''],
  ['DJI Mavic 3T', '553', '2024-07-21 19:11', '2024-07-21 19:43', 32, 1876, 178, '', '', 0, 0, 1, ''],

  ['DJI Mavic 3T', '553', '2024-05-14 09:16', '2024-05-14 09:49', 33, 678, 178, 'Albania', 'GH89', 20, 19, 2, ''],
  ['DJI Mavic 3T', '553', '2024-05-17 19:04', '2024-05-17 19:31', 27, 51, 178, '', '', 0, 0, 2, ''],
  ['DJI Mavic 3T', '553', '2024-05-19 13:07', '2024-05-19 13:21', 14, 7, 178, '', '', 0, 0, 2, ''],

  ['DJI Mavic 3T', '553', '2024-08-20 23:48', '2024-08-20 23:59', 11, 8763, 178, 'flight in the forest', 'JLE5', 12, 89, 3, ''],
  ['DJI Mavic 3T', '553', '2024-08-21 03:48', '2024-08-21 03:59', 11, 19877, 344, '', '', 0, 0, 3, ''],
  ['DJI Mavic 3T', '553', '2024-08-21 04:41', '2024-08-21 05:03', 22, 6354, 345, '', '', 0, 0, 3, ''],

  ['DJI Mavic 3T', '567', '2024-09-21 06:13', '2024-09-21 06:17', 4, 234, 678, '', '', 0, 0, 4, ''],
  ['DJI Mavic 3T', '567', '2024-09-21 10:04', '2024-09-21 10:17', 13, 8774, 244, '', '', 0, 0, 4, ''],
  ['DJI Mavic 3T', '567', '2024-09-21 10:27', '2024-09-21 10:33', 6, 2345, 98, '', '', 0, 0, 4, ''],
  ['DJI Mavic 3T', '567', '2024-09-21 10:41', '2024-09-21 10:58', 17, 8474, 134, 'підарський ліс', 'JSQ1', 11, 65, 4, ''],

  ['DJI Mavic 3 Pro', '599', '2024-04-21 16:13', '2024-04-21 16:21', 8, 233, 67, '', '', 0, 0, 5, ''],
  ['DJI Mavic 3 Pro', '599', '2024-04-21 16:57', '2024-04-21 17:09', 12, 987, 345, '', '', 0, 0, 5, ''],
  ['DJI Mavic 3 Pro', '599', '2024-04-21 19:11', '2024-04-21 19:43', 32, 2847, 374, '', '', 0, 0, 5, ''],

  ['DJI Mavic 3 Pro', '599', '2025-03-14 09:16', '2025-03-14 09:49', 33, 2344, 234, '', '', 0, 0, 6, ''],

  ['Autel Evo Max 4T', '505', '2025-03-17 19:04', '2025-03-17 19:31', 27, 988, 987, '', '', 0, 0, 7, ''],

  ['Autel Evo Max 4T', '505', '2025-03-19 13:07', '2025-03-19 13:21', 14, 7662, 234, '', '', 0, 0, 8, ''],

  ['Autel Evo Max 4T', '505', '2025-06-20 23:48', '2025-06-20 23:59', 11, 10234, 55, '', '', 0, 0, 9, ''],

  ['Autel Evo Max 4T', '505', '2025-06-21 03:48', '2025-06-21 03:59', 11, 7364, 234, '', '', 0, 0, 10, ''],
  ['Autel Evo Max 4T', '505', '2025-06-21 04:41', '2025-06-21 05:03', 22, 9834, 645, '', '', 0, 0, 10, ''],
  ['Autel Evo Max 4T', '505', '2025-06-21 06:13', '2025-06-21 06:17', 4, 234, 231, '', '', 0, 0, 10, ''],
  ['Autel Evo Max 4T', '505', '2025-06-21 10:04', '2025-06-21 10:17', 13, 123, 56, '', '', 0, 0, 10, ''],
  ['Autel Evo Max 4T', '505', '2025-06-21 10:27', '2025-06-21 10:33', 6, 9800, 876, '', '', 0, 0, 10, ''],
  ['DJI Mavic 4T', '607', '2025-06-21 10:41', '2025-06-21 10:58', 17, 2345, 234, '', '', 0, 0, 10, ''],
  ['DJI Mavic 4T', '607', '2025-06-21 16:13', '2025-06-21 16:21', 8, 9384, 889, '', '', 0, 0, 10, ''],
  ['DJI Mavic 4T', '607', '2025-06-21 16:57', '2025-06-21 17:09', 12, 2356, 543, 'this still requires you to click the done button to focus to next input. how about auto focus. auto move to next field?', '13UQ', 3, 61, 10, ''],
  ['DJI Mavic 4T', '607', '2025-06-21 19:11', '2025-06-21 19:43', 32, 19484, 234, '', '', 0, 0, 10, ''],

  ['DJI Mavic 4T', '607', '2025-05-14 09:16', '2025-05-14 09:49', 33, 2345, 234, '', '', 0, 0, 11, ''],
  ['DJI Mavic 4T', '607', '2025-05-14 19:04', '2025-05-14 19:31', 27, 874, 665, '', '', 0, 0, 11, ''],

  ['DJI Matrice 30T', '704', '2025-05-19 13:07', '2025-05-19 13:21', 14, 2345, 127, '', '', 0, 0, 12, ''],

  ['DJI Matrice 30T', '704', '2025-05-27 23:37', '2025-05-28 00:08', 31, 2948, 66, '', '', 0, 0, 13, ''],

  ['DJI Matrice 30T', '704', '2025-06-19 23:51', '2025-06-20 00:29', 38, 18733, 1324, '', '', 0, 0, 14, ''],
];

///
///
///
Future<void> createDummyData() async {
  /// hardcoded not real ids used later for getting real shift ids
  final hardShiftIds = <int>[];
  final realShiftIds = <int>[];
  List<ShiftModel> shifts = [];
  final logIds = <int>[];
  final logs = <FlightLogModel>[];
  final countsOfLogsInShifts = <int>[];

  for (var i = 0; i < logsData.length; i++) {
    var hardShiftId = logsData[i][11];
    if (!hardShiftIds.contains(hardShiftId)) {
      hardShiftIds.add(hardShiftId);
    }
  }

  /// making empty shifts
  for (var i = 0; i < hardShiftIds.length; i++) {
    var id = await addShiftToDb(BaseShiftModel());
    realShiftIds.add(id);

    var shift = await getShiftFromDb(id);
    if (shift is ShiftModel) {
      shifts.add(shift);
    }
  }

  /// making logs with real data
  var index = 0;
  int prevHardShId = logsData[0][11];
  int logsInShiftCount = 0;
  for (var i = 0; i < logsData.length; i++) {
    int hardShId = logsData[i][11];
    int realShId = realShiftIds[index];

    if (prevHardShId != hardShId) {
      prevHardShId = hardShId;
      index++;
      realShId = realShiftIds[index];
      countsOfLogsInShifts.add(logsInShiftCount);
      logsInShiftCount = 0;
    }

    var id = await addFlightLogToDb(
      BaseFlightLogModel(
        droneName: logsData[i][0],
        droneId: logsData[i][1],
        takeoffDateAndTime: logsData[i][2],
        landingDateAndTime: logsData[i][3],
        flightTimeMinutes: logsData[i][4],
        distanceMeters: logsData[i][5],
        altitudeMeters: logsData[i][6],
        location: logsData[i][7],
        droneAccum: logsData[i][8],
        droneAccumChargeLeft: logsData[i][9],
        rcAccumChargeLeft: logsData[i][10],
        shiftId: realShId,
        note: logsData[i][12],
      ),
    );

    var log = await getFlightLogFromDb(id);
    if (log is FlightLogModel) {
      logs.add(log);
      logIds.add(id);
      logsInShiftCount++;

      if (i == logsData.length - 1) {
        countsOfLogsInShifts.add(logsInShiftCount);
      }
    }
  }

  /// making chunks of logs from which to get log.id
  /// and insert into shift.logIds
  final logsInShifts = <List<FlightLogModel>>[];
  var accumLength = 0;
  for (var i = 0; i < shifts.length; i++) {
    bool isFirstIndex = i == 0;
    bool isLastIndex = i == shifts.length - 1;

    var logsChunk = <FlightLogModel>[];
    if (isFirstIndex) {
      logsChunk = logs.sublist(0, countsOfLogsInShifts[0]);
    }
    else if (isLastIndex) {
      var lastCountIndex = countsOfLogsInShifts.length - 1;
      var lastCount = countsOfLogsInShifts[lastCountIndex];
      logsChunk = logs.sublist(logs.length - lastCount);
    }
    else {
      var countIndex = accumLength + countsOfLogsInShifts[i];
      logsChunk = logs.sublist(accumLength, countIndex);
    }

    logsInShifts.add(logsChunk);
    accumLength = accumLength + countsOfLogsInShifts[i];
  }

  var lastLandingDateAndTime = '';
  var idOfLastFlightLog = -1; // based on lastLandingDateAndTime
  var idOfLastShift = -1; // based on idOfLastFlightLog

  /// adding real data from logs to shifts
  for (var i = 0; i < shifts.length; i++) {
    List<FlightLogModel> logsOfCurrShift = logsInShifts[i];

    var latestLogRec = addDataToShift(shifts[i], logsOfCurrShift);

    if (lastLandingDateAndTime.isEmpty) {
      lastLandingDateAndTime = latestLogRec.lastLandingDateAndTime;
      idOfLastFlightLog = latestLogRec.idOfLastFlightLog;
      idOfLastShift = latestLogRec.idOfLastShift;
    } else {
      bool isLogLandingLater = isFirstDateAndTimeLater(
        latestLogRec.lastLandingDateAndTime,
        lastLandingDateAndTime,
      );
      if (isLogLandingLater) {
        lastLandingDateAndTime = latestLogRec.lastLandingDateAndTime;
        idOfLastFlightLog = latestLogRec.idOfLastFlightLog;
        idOfLastShift = latestLogRec.idOfLastShift;
      }
    }

    await updateShiftInDbRaw(shifts[i]);
  }

  /// updating home
  var homeData = await getHomeFromDb();
  var lastLogFromHome = await getFlightLogFromDb(homeData.lastFlightLogId);

  addDataToHome(
    homeData,
    shifts,
    lastLogFromHome,
    lastLandingDateAndTime,
    idOfLastFlightLog,
    idOfLastShift,
  );

  await updateHomeInDb(
    topFlightTimeMinutes: homeData.topFlightTimeMinutes,
    topDistanceMeters: homeData.topDistanceMeters,
    topAltitudeMeters: homeData.topAltitudeMeters,
    lastShiftId: homeData.lastShiftId,
    lastFlightLogId: homeData.lastFlightLogId,
  );
}

///
///
///
class LatestLogRecord {
  String lastLandingDateAndTime;
  int idOfLastFlightLog;
  int idOfLastShift;

  LatestLogRecord({
    this.lastLandingDateAndTime = '',
    this.idOfLastFlightLog = -1,
    this.idOfLastShift = -1,
  });
}

///
///
///
LatestLogRecord addDataToShift(ShiftModel shift, List<FlightLogModel> logs) {
  shift.logIds = logs.map((log) => log.id).toList();
  shift.flightsQty = logs.length;

  var latestLogRec = LatestLogRecord(idOfLastShift: shift.id);

  for (var y = 0; y < logs.length; y++) {
    var log = logs[y];
    var isFirstElem = y == 0;

    if (isFirstElem || logs.length == 1) {
      shift.startedAtDateAndTime = log.takeoffDateAndTime;
      shift.endedAtDateAndTime = log.landingDateAndTime;
      latestLogRec.lastLandingDateAndTime = log.landingDateAndTime;
      latestLogRec.idOfLastFlightLog = log.id;
      shift.timeTotalMinutes = log.flightTimeMinutes;
      shift.longestFlightTimeMinutes = log.flightTimeMinutes;
      shift.longestDistanceMeters = log.distanceMeters;
      shift.highestAltitudeMeters = log.altitudeMeters;
    } else {
      if (isFirstElem) {
        continue;
      }

      bool isLogTakeoffEarlier = isFirstDateAndTimeEarlier(
        log.takeoffDateAndTime,
        shift.startedAtDateAndTime,
      );
      if (isLogTakeoffEarlier) {
        shift.startedAtDateAndTime = log.takeoffDateAndTime;
      }

      bool isLogLandingLater = isFirstDateAndTimeLater(
        log.landingDateAndTime,
        shift.endedAtDateAndTime,
      );
      if (isLogLandingLater) {
        shift.endedAtDateAndTime = log.landingDateAndTime;
        latestLogRec.lastLandingDateAndTime = log.landingDateAndTime;
        latestLogRec.idOfLastFlightLog = log.id;
      }

      shift.timeTotalMinutes += log.flightTimeMinutes;

      if (log.flightTimeMinutes > shift.longestFlightTimeMinutes) {
        shift.longestFlightTimeMinutes = log.flightTimeMinutes;
      }

      if (log.distanceMeters > shift.longestDistanceMeters) {
        shift.longestDistanceMeters = log.distanceMeters;
      }

      if (log.altitudeMeters > shift.highestAltitudeMeters) {
        shift.highestAltitudeMeters = log.altitudeMeters;
      }
    }
  }

  return latestLogRec;
}

///
///
///
void addDataToHome(
  HomeModel homeData,
  List<ShiftModel> shifts,
  FlightLogModel? lastLogFromHome,
  String lastLandingDateAndTime,
  int idOfLastFlightLog,
  int idOfLastShift,
) {
  for (var i = 0; i < shifts.length; i++) {
    if (shifts[i].longestFlightTimeMinutes > homeData.topFlightTimeMinutes) {
      homeData.topFlightTimeMinutes = shifts[i].longestFlightTimeMinutes;
    }
    if (shifts[i].longestDistanceMeters > homeData.topDistanceMeters) {
      homeData.topDistanceMeters = shifts[i].longestDistanceMeters;
    }
    if (shifts[i].highestAltitudeMeters > homeData.topAltitudeMeters) {
      homeData.topAltitudeMeters = shifts[i].highestAltitudeMeters;
    }
  }

  if (lastLogFromHome is FlightLogModel) {
    bool isNewLatestLogAppeared = isFirstDateAndTimeLater(
      lastLandingDateAndTime,
      lastLogFromHome.landingDateAndTime,
    );
    if (isNewLatestLogAppeared) {
      homeData.lastFlightLogId = idOfLastFlightLog;
      homeData.lastShiftId = idOfLastShift;
    }
  } else {
    homeData.lastFlightLogId = idOfLastFlightLog;
    homeData.lastShiftId = idOfLastShift;
  }
}
