import '../utils/date_time/get_date_string_without_time.dart';
import '../utils/date_time/is_first_date_and_time_earlier.dart';
import '../utils/date_time/is_first_date_and_time_later.dart';
import '../utils/date_time/parse_date_and_time.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../utils/extract_ids.dart';
import '../utils/extract_int.dart';
import '../flight_logs/flight_log_model.dart';
import '../home/home_model.dart';
import '../shifts/shift_model.dart';
import 'db.dart';

// ====================== HOME ======================

///
/// Get home from db
///
Future<HomeModel> getHomeFromDb() async {
  final db = await database;
  final homeMapList = await db.query('Home');

  if (homeMapList.isNotEmpty) {
    final homeMap = homeMapList.first;

    return HomeModel(
      topFlightTimeMinutes: homeMap['topFlightTimeMinutes'] as int,
      topDistanceMeters: homeMap['topDistanceMeters'] as int,
      topAltitudeMeters: homeMap['topAltitudeMeters'] as int,
      lastShiftId: homeMap['lastShiftId'] as int,
      lastFlightLogId: homeMap['lastFlightLogId'] as int,
    ); 
  }

  return HomeModel();
}

///
/// Update home in db
///
Future<void> updateHomeInDb({
  int? topFlightTimeMinutes,
  int? topDistanceMeters,
  int? topAltitudeMeters,
  int? lastShiftId,
  int? lastFlightLogId,
}) async {
  try {
    final db = await database;
    final homeMap = await db.query('Home');

    if (homeMap.isNotEmpty) {
      final origMap = homeMap.first;
      final Map<String, int> data = {
        'topFlightTimeMinutes': topFlightTimeMinutes ?? origMap['topFlightTimeMinutes'] as int,
        'topDistanceMeters': topDistanceMeters ?? origMap['topDistanceMeters'] as int,
        'topAltitudeMeters': topAltitudeMeters ?? origMap['topAltitudeMeters'] as int,
        'lastShiftId': lastShiftId ?? origMap['lastShiftId'] as int,
        'lastFlightLogId': lastFlightLogId ?? origMap['lastFlightLogId'] as int,
      };

      await db.update('Home', data);

    } else {
      final defaultHome = HomeModel();
      final Map<String, int> data = {
        'topFlightTimeMinutes': topFlightTimeMinutes ?? defaultHome.topFlightTimeMinutes,
        'topDistanceMeters': topDistanceMeters ?? defaultHome.topDistanceMeters,
        'topAltitudeMeters': topAltitudeMeters ?? defaultHome.topAltitudeMeters,
        'lastShiftId': lastShiftId ?? defaultHome.lastShiftId,
        'lastFlightLogId': lastFlightLogId ?? defaultHome.lastFlightLogId,
      };

      await db.insert('Home', data);
    }
  } catch (err) {
    print('[updateHomeInDb] ERR: $err');
  }
}

// ====================== FLIGHT LOGS ======================

///
/// Create a flight log in db
///
Future<int> addFlightLogToDb(BaseFlightLogModel log) async {
  try {
    final db = await database;

    int id = await db.insert(
      'FlightLog',
      log.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  } catch (err) {
    print('[addFlightLogToDb] ERR: $err');

    return -1;
  }
}

class FlightLogsResult {
  List<FlightLogModel> logs;
  int totalCount;

  FlightLogsResult({
    this.logs = const [],
    this.totalCount = 0,
  });
}

///
/// Get many flight logs from db
///
Future<List<FlightLogModel>> getFlightLogsFromDb({ int? offset, int? limit }) async {
  try {
    final db = await database;

    final limitInt = limit ?? 20;
    final offsetInt = offset ?? 0;

    final List<Map<String, Object?>> logsMapList = await db.rawQuery(
      '''SELECT * FROM FLIGHTLOG
           ORDER BY takeoffDateAndTime DESC
           LIMIT $limitInt
           OFFSET $offsetInt
      '''
    );

    // Convert the list of each log's fields into a list of `Log` objects.
    return [
      for (final {
      'id': id as int,
      'shiftId': shiftId as int,
      'droneName': droneName as String,
      'droneId': droneId as String,
      'takeoffDateAndTime': takeoffDateAndTime as String,
      'landingDateAndTime': landingDateAndTime as String,
      'flightTimeMinutes': flightTimeMinutes as int,
      'distanceMeters': distanceMeters as int,
      'altitudeMeters': altitudeMeters as int,
      'location': location as String,
      'droneAccum': droneAccum as String,
      'droneAccumChargeLeft': droneAccumChargeLeft as int,
      'rcAccumChargeLeft': rcAccumChargeLeft as int,
      'note': note as String,
      } in logsMapList)
        FlightLogModel(
          id: id,
          shiftId: shiftId,
          droneName: droneName,
          droneId: droneId,
          takeoffDateAndTime: takeoffDateAndTime,
          landingDateAndTime: landingDateAndTime,
          flightTimeMinutes: flightTimeMinutes,
          distanceMeters: distanceMeters,
          altitudeMeters: altitudeMeters,
          location: location,
          droneAccum: droneAccum,
          droneAccumChargeLeft: droneAccumChargeLeft,
          rcAccumChargeLeft: rcAccumChargeLeft,
          note: note,
        ),
    ];
  } catch (err) {
    print('[getFlightLogsFromDb] ERR: $err');

    return [];
  }
}

///
/// Get flight logs from db by their ids
///
Future<List<FlightLogModel>> getFlightLogsByIdsFromDb({ List<int> ids = const [] }) async {
  final db = await database;
  List<FlightLogModel> logs = [];

  for (final id in ids) {
    final List<Map<String, Object?>> logsMapList = await db.query(
      'FlightLog',
      where: 'id = ?',
      whereArgs: [id],
    );

    for (final {
          'id': id as int,
          'shiftId': shiftId as int,
          'droneName': droneName as String,
          'droneId': droneId as String,
          'takeoffDateAndTime': takeoffDateAndTime as String,
          'landingDateAndTime': landingDateAndTime as String,
          'flightTimeMinutes': flightTimeMinutes as int,
          'distanceMeters': distanceMeters as int,
          'altitudeMeters': altitudeMeters as int,
          'location': location as String,
          'droneAccum': droneAccum as String,
          'droneAccumChargeLeft': droneAccumChargeLeft as int,
          'rcAccumChargeLeft': rcAccumChargeLeft as int,
          'note': note as String,
        } in logsMapList) {
      logs.add(
        FlightLogModel(
          id: id,
          shiftId: shiftId,
          droneName: droneName,
          droneId: droneId,
          takeoffDateAndTime: takeoffDateAndTime,
          landingDateAndTime: landingDateAndTime,
          flightTimeMinutes: flightTimeMinutes,
          distanceMeters: distanceMeters,
          altitudeMeters: altitudeMeters,
          location: location,
          droneAccum: droneAccum,
          droneAccumChargeLeft: droneAccumChargeLeft,
          rcAccumChargeLeft: rcAccumChargeLeft,
          note: note,
        ),
      );
    }
  }

  return logs;
}

///
/// Get a flight log from db
///
Future<FlightLogModel?> getFlightLogFromDb(int id) async {
  final db = await database;

  final List<Map<String, Object?>> logsMapList = await db.query(
    'FlightLog',
    where: 'id = ?',
    whereArgs: [id],
  );

  if (logsMapList.isNotEmpty) {
    final logMap = logsMapList.first;

    return FlightLogModel(
      id: id,
      shiftId: logMap['shiftId'] as int,
      droneName: logMap['droneName'] as String,
      droneId: logMap['droneId'] as String,
      takeoffDateAndTime: logMap['takeoffDateAndTime'] as String,
      landingDateAndTime: logMap['landingDateAndTime'] as String,
      flightTimeMinutes: logMap['flightTimeMinutes'] as int,
      distanceMeters: logMap['distanceMeters'] as int,
      altitudeMeters: logMap['altitudeMeters'] as int,
      location: logMap['location'] as String,
      droneAccum: logMap['droneAccum'] as String,
      droneAccumChargeLeft: logMap['droneAccumChargeLeft'] as int,
      rcAccumChargeLeft: logMap['rcAccumChargeLeft'] as int,
      note: logMap['note'] as String,
    ); 
  }

  return null;
}

///
/// Update a flight log in db
///
// TODO: make payload type or class
Future<int> updateFlightLogInDb(int id, BaseFlightLogModel log) async {
  final db = await database;

  int changesCount = await db.update(
    'FlightLog',
    log.toMap(),
    where: 'id = ?',
    whereArgs: [id],
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  return changesCount;
}

///
/// Remove a flight log from db
///
Future<bool> removeFlightLogFromDb(int id) async {
  try {
    final db = await database;

    int changesCount = await db.delete(
      'FlightLog',
      where: 'id = ?',
      whereArgs: [id],
    );

    return changesCount == 1 ? true : false;
  } catch (err) {
    print('[removeFlightLogFromDb] ERR: $err');

    return false;
  }
}

///
///
///
Future<int> getLastFlightLogIdFromDb() async {
  try {
    final db = await database;
    final List<Map<String, Object?>> shiftsMapList = await db.rawQuery(
      '''SELECT * FROM FLIGHTLOG
           ORDER BY takeoffDateAndTime DESC
           LIMIT 1
           OFFSET 0
      '''
    );

    final lastShiftId = shiftsMapList.isNotEmpty
        ? shiftsMapList.first['id'] as int
        : -1;

    return lastShiftId;
  } catch (err) {
    print('[getLastShiftIdFromDb] ERR: $err');

    return -1;
  }
}

// ====================== SHIFTS ======================

///
/// Create a shift in db
///
Future<int> addShiftToDb(BaseShiftModel shift) async {
  try {
    final db = await database;

    int id = await db.insert(
      'Shift',
      shift.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await updateHomeInDb(lastShiftId: id);

    return id;
  } catch (err) {
    print('[addShiftToDb] ERR: $err');

    return -1;
  }
}

class ShiftsResult {
  List<ShiftModel> shifts;
  int totalCount;
  String fromDate;
  String toDate;

  ShiftsResult({
    // 'required' to avoid 'Cannot remove from an unmodifiable list' error in removeShift
    required this.shifts,
    this.totalCount = 0,
    this.fromDate = '',
    this.toDate = '',
  });

  Map<String, Object?> toMap() {
    return {
      'shifts': shifts.map((shift) => shift.toMap()),
      'totalCount': totalCount,
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }
}

///
/// Get many shifts from db
///
Future<ShiftsResult> getShiftsFromDb({
  int? limit,
  int? offset,
  DateTime? fromDate,
  DateTime? toDate,
}) async {
  final db = await database;

  final limitInt = limit ?? 20;
  final offsetInt = offset ?? 0;
  final fromStr = getDateStringWithoutTimeFromDateTime(
    fromDate ?? DateTime(1970),
  );
  final toStr = getDateStringWithoutTimeFromDateTime(
    // adding one day to include shifts ended till 23:59 of toDate
    (toDate ?? DateTime.now()).add(const Duration(days: 1))
  );

  final List<Map<String, Object?>> shiftsMapList = await db.rawQuery(
    '''SELECT * FROM SHIFT WHERE
         strftime("%s", startedAtDateAndTime)
         BETWEEN strftime("%s", "$fromStr") AND strftime("%s", "$toStr")
         ORDER BY startedAtDateAndTime DESC
         LIMIT $limitInt
         OFFSET $offsetInt
    '''
  );
  final List<Map<String, Object?>> totalCountMap = await db.rawQuery(
    'SELECT COUNT(*) FROM SHIFT'
  ); // e.g. [{COUNT(*): 117}]

  List<ShiftModel> shifts = [];
  int totalCount = totalCountMap.first['COUNT(*)'] as int;

  for (final {
        'id': id as int,
        'logIds': logIds as String, // e.g. 1,8,19,25,36...
        'startedAtDateAndTime': startedAtDateAndTime as String,
        'endedAtDateAndTime': endedAtDateAndTime as String,
        'flightsQty': flightsQty as int,
        'timeTotalMinutes': timeTotalMinutes as int,
        'longestFlightTimeMinutes': longestFlightTimeMinutes as int,
        'longestDistanceMeters': longestDistanceMeters as int,
        'highestAltitudeMeters': highestAltitudeMeters as int,
      } in shiftsMapList) {

    shifts.add(ShiftModel(
      id: id,
      logIds: logIds.split(',').map(extractInt).toList(),
      startedAtDateAndTime: startedAtDateAndTime,
      endedAtDateAndTime: endedAtDateAndTime,
      flightsQty: flightsQty,
      timeTotalMinutes: timeTotalMinutes,
      longestFlightTimeMinutes: longestFlightTimeMinutes,
      longestDistanceMeters: longestDistanceMeters,
      highestAltitudeMeters: highestAltitudeMeters,
    ));
  }

  return ShiftsResult(
    shifts: shifts,
    totalCount: totalCount,
    fromDate: fromStr,
    toDate: toStr,
  );
}

///
/// Get a shift from db
///
Future<ShiftModel?> getShiftFromDb(int id) async {
  final db = await database;

  final List<Map<String, Object?>> shiftsMapList = await db.query(
    'Shift',
    where: 'id = ?',
    whereArgs: [id],
  );

  if (shiftsMapList.isNotEmpty) {
    final shiftMap = shiftsMapList.first;

    return ShiftModel(
      id: shiftMap['id'] as int,
      logIds: extractIds(shiftMap['logIds'] as String),
      startedAtDateAndTime: shiftMap['startedAtDateAndTime'] as String,
      endedAtDateAndTime: shiftMap['endedAtDateAndTime'] as String,
      flightsQty: shiftMap['flightsQty'] as int,
      timeTotalMinutes: shiftMap['timeTotalMinutes'] as int,
      longestFlightTimeMinutes: shiftMap['longestFlightTimeMinutes'] as int,
      longestDistanceMeters: shiftMap['longestDistanceMeters'] as int,
      highestAltitudeMeters: shiftMap['highestAltitudeMeters'] as int,
    ); 
  }

  return null;
}

///
///
///
Future<int> updateShiftInDbAfterFlightLogRemoved(ShiftModel updatedShift) async {
  final db = await database;

  int changesCount = await db.update(
    'Shift',
    updatedShift.toMap(),
    where: 'id = ?',
    whereArgs: [updatedShift.id],
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  return changesCount;
}

///
/// Update a shift in db
/// If logBeforeUpdate is null, then a new log is added to shift
Future<int> updateShiftInDb(int id, FlightLogModel log, FlightLogModel? logBeforeUpdate) async {
  ShiftModel? shift = await getShiftFromDb(id);

  if (shift != null) {
    var updatedShift = BaseShiftModel(
      logIds: shift.logIds,
      startedAtDateAndTime: shift.startedAtDateAndTime,
      endedAtDateAndTime: shift.endedAtDateAndTime,
      flightsQty: shift.flightsQty,
      timeTotalMinutes: shift.timeTotalMinutes,
      longestFlightTimeMinutes: shift.longestFlightTimeMinutes,
      longestDistanceMeters: shift.longestDistanceMeters,
      highestAltitudeMeters: shift.highestAltitudeMeters,
    );

    if (!updatedShift.logIds.contains(log.id)) {
      updatedShift.logIds.add(log.id);
    }

    bool isSingleLog = updatedShift.logIds.length == 1;

    if (updatedShift.startedAtDateAndTime.isEmpty || isSingleLog) {
      updatedShift.startedAtDateAndTime = log.takeoffDateAndTime;
    } else {
      bool isLogTakeoffEarlier = isFirstDateAndTimeEarlier(
        log.takeoffDateAndTime,
        updatedShift.startedAtDateAndTime,
      );

      if (isLogTakeoffEarlier) {
        updatedShift.startedAtDateAndTime = log.takeoffDateAndTime;
      }
    }

    if (updatedShift.endedAtDateAndTime.isEmpty || isSingleLog) {
      updatedShift.endedAtDateAndTime = log.landingDateAndTime;
    } else {
      bool isLogLandingLater = isFirstDateAndTimeLater(
        log.landingDateAndTime,
        updatedShift.endedAtDateAndTime,
      );

      if (isLogLandingLater) {
        updatedShift.endedAtDateAndTime = log.landingDateAndTime;
      }
    }

    updatedShift.flightsQty = updatedShift.logIds.length;

    if (updatedShift.timeTotalMinutes == 0) {
      updatedShift.timeTotalMinutes = log.flightTimeMinutes;
    } else {
      if (logBeforeUpdate == null) {
        updatedShift.timeTotalMinutes += log.flightTimeMinutes;
      } else {
        updatedShift.timeTotalMinutes =
          updatedShift.timeTotalMinutes -
          logBeforeUpdate.flightTimeMinutes +
          log.flightTimeMinutes;
      }
    }

    if (updatedShift.longestFlightTimeMinutes < log.flightTimeMinutes) {
      updatedShift.longestFlightTimeMinutes = log.flightTimeMinutes;
    }

    if (updatedShift.longestDistanceMeters < log.distanceMeters) {
      updatedShift.longestDistanceMeters = log.distanceMeters;
    }

    if (updatedShift.highestAltitudeMeters < log.altitudeMeters) {
      updatedShift.highestAltitudeMeters = log.altitudeMeters;
    }

    final db = await database;

    int changesCount = await db.update(
      'Shift',
      updatedShift.toMap(),
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return changesCount;
  }

  return 0;
}

///
///
///
Future<bool> updateShiftInDbRaw(ShiftModel shift) async {
  try {
    final db = await database;

    int changesCount = await db.update(
      'Shift',
      shift.toMap(),
      where: 'id = ?',
      whereArgs: [shift.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return changesCount == 1 ? true : false;
  } catch (err) {
    print('[updateShiftInDbRaw] ERR: $err');

    return false;
  }
}

///
/// Remove a shift from db
///
Future<bool> removeShiftFromDb(int id) async {
  try {
    final db = await database;

    int changesCount = await db.delete(
      'Shift',
      where: 'id = ?',
      whereArgs: [id],
    );

    return changesCount == 1 ? true : false;
  } catch (err) {
    print('[removeShiftFromDb] ERR: $err');

    return false;
  }
}

///
///
///
Future<int> getShiftsTotalCountFromDb() async {
  try {
    final db = await database;
    final List<Map<String, Object?>> totalCountMap = await db.rawQuery(
      'SELECT COUNT(*) FROM SHIFT',
    ); // [{COUNT(*): int}]
    final int totalCount = totalCountMap.first['COUNT(*)'] as int;

    return totalCount;
  } catch (err) {
    print('[getShiftsTotalCountFromDb] ERR: $err');

    return -1;
  }
}

///
///
///
Future<int> getLastShiftIdFromDb() async {
  try {
    final db = await database;
    final List<Map<String, Object?>> shiftsMapList = await db.rawQuery(
      '''SELECT * FROM SHIFT
           ORDER BY startedAtDateAndTime DESC
           LIMIT 1
           OFFSET 0
      '''
    );

    final lastShiftId = shiftsMapList.isNotEmpty
        ? shiftsMapList.first['id'] as int
        : -1;

    return lastShiftId;
  } catch (err) {
    print('[getLastShiftIdFromDb] ERR: $err');

    return -1;
  }
}
