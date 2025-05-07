// import 'package:flights_logger/src/sample_feature/sample_item_list_view.dart';
// import 'dart:io';
// import 'dart:async';
// import 'package:flights_logger/src/app_state_init_data.dart';
// import 'package:flights_logger/src/flight_logs/flight_log.dart';
import 'package:flights_logger/src/utils/get_last_date_and_time_index.dart';
import 'package:flutter/material.dart';
// import 'package:path/path.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// import 'sample_feature/sample_item_details_view.dart';
// import 'app_state_init_data_model.dart';
import 'db/queries.dart';
import 'flight_logs/flight_log_model.dart';
// import 'home/home_model.dart';
import 'home/home_model.dart';
import 'shifts/filter_shifts.dart';
import 'shifts/shift.dart';
import 'shifts/shift_model.dart';

// import 'app_dummy_data.dart';
import 'app_storage.dart';

// enum FlightLogOriginType {
//   noShift,
//   singleShift,
//   newShift,
// }

class ShiftsTotalCou {
  int value;
  ShiftsTotalCou(this.value);
}

class MyAppState with ChangeNotifier {
  // MyAppState(this.initData);

  // final AppStateInitDataModel initData;
  // late HomeModel initData;

  // ============================= FLIGHT LOGS ===================
  // MyAppStorage appStorage = MyAppStorage();

  List<String> history = [];

  List<String> getHistory() {
    return history;
  }

  String getPrevRouteFromHistory() {
    if (history.length > 1) {
      print('          [getPrevRouteFromHistory CURR] - $history');
      print('          [getPrevRouteFromHistory RETU] - ${history.elementAt(history.length - 2)}');
      return history.elementAt(history.length - 2);
    }

    return '';
  }

  void addToHistory(String routeName) {
    print('           [history ADD BEF] - $history');
    // if (history.isEmpty || history.last != routeName) {
    if (history.isEmpty || !history.contains(routeName)) {
      history.add(routeName);
      print('           [history ADD AFT] - $history');
    }
  }

  void removeFromHistory(String routeName) {
    print('           [history REM BEF] - $history');
    if (history.isNotEmpty && history.last == routeName) {
      history.removeLast();
      print('           [history REM AFT] - $history');
    }
  }

  // AppStateInitData appStateInitDat = appStateInitData;
  // List<FlightLogModel> flightLogs = dummyFlightLogs;
  bool isSingleShiftMode = false;
  ShiftModel? singleShift;

  List<FlightLogModel> flightLogs = [];
  List<int> flightLogsIds = [];

  List<FlightLogModel> singleShiftFlightLogs = [];
  List<int> singleShiftFlightLogsIds = [];

  List<FlightLogModel> newShiftFlightLogs = [];
  List<int> newShiftFlightLogsIds = [];

  // List<FlightLogModel> lastFlightLogs = [];

  // List<ShiftModel> shifts = dummyShifts;
  List<ShiftModel> shifts = [];
  List<int> shiftsIds = [];
  int shiftsTotalCount = 0;
  bool sho = false;
  int shoInt = 0;

  /// TODO: split to shifts and shiftsTotalCount because there's an error
  ///       when you click 'New shift' --> 'New log' and then back, back:
  /// 'UnsupportedError (Unsupported operation: Cannot remove from an unmodifiable list)'

  ShiftsResult shiftsRes = ShiftsResult(shifts: []);

  // WORK ======================
  // List<int> shiftsTotalCountArr = [0];

  // Map<String, int> shiftsTotalCou = { 'value': 0 };
  // ShiftsTotalCou shiftsTotalCou = ShiftsTotalCou(100);
  // ShiftsTotalCou shiftsTotalCouInit = ShiftsTotalCou(50);

  List<ShiftModel> selectedShifts = [];
  // selectedShifts.add(shifts.get[0]);





















  ///
  /// UPDATE FLIGHT LOGS
  ///
  void updateFlightLogs({
    List<FlightLogModel> givenLogs = const [],
    List<int> idsForReload = const [],
  }) {
    try {
      if (
        (flightLogsIds.isEmpty && flightLogs.isNotEmpty) ||
        (flightLogsIds.isNotEmpty && flightLogs.isEmpty)
      ) {
        throw Error();
      }

      if (flightLogsIds.isEmpty) {
        print('[updateFlightLogs] empty');
        flightLogs = givenLogs;
        flightLogsIds = givenLogs.map((log) => log.id).toList();
      } else {
        /// check to avoid inserting a duplicate flight log
        for (final log in givenLogs) {
          bool isDuplicate = flightLogsIds.contains(log.id);
          if (isDuplicate) {
            print('[updateFlightLogs] isDuplicate, log.id - ${log.id}, idsForReload - $idsForReload');
            if (idsForReload.contains(log.id)) {
              print('[updateFlightLogs] idsForReload.contains id - ${log.id}');
              replaceFlightLog(log);
            }
          } else {
            flightLogs.add(log);
            flightLogsIds.add(log.id);
          }
        }
      }
    } catch (e) {
      print('[ERR]: flightLogs and flightLogsIds length are not equal');
    }
  }

  ///
  /// UPDATE SINGLE SHIFT FLIGHT LOGS
  ///
  void updateSingleShiftFlightLogs({
    List<FlightLogModel> givenLogs = const [],
    List<int> idsForReload = const [],
  }) {
    try {
      if (
        (singleShiftFlightLogsIds.isEmpty && singleShiftFlightLogs.isNotEmpty) ||
        (singleShiftFlightLogsIds.isNotEmpty && singleShiftFlightLogs.isEmpty)
      ) {
        throw Error();
      }

      if (singleShiftFlightLogsIds.isEmpty) {
        singleShiftFlightLogs = givenLogs;
        singleShiftFlightLogsIds = givenLogs.map((log) => log.id).toList();
      } else {
        for (final log in givenLogs) {
          bool isDuplicate = singleShiftFlightLogsIds.contains(log.id);
          if (isDuplicate) {
            print('[updateSingleShiftFlightLogs] isDuplicate, log.id - ${log.id}, idsForReload - $idsForReload');
            if (idsForReload.contains(log.id)) {
              print('[updateSingleShiftFlightLogs] idsForReload.contains id - ${log.id}');
              replaceSingleShiftFlightLog(log);
            }
          } else {
            singleShiftFlightLogs.add(log);
            singleShiftFlightLogsIds.add(log.id);
          }
        }
      }
    } catch (e) {
      print('[ERR]: singleShiftFlightLogs and singleShiftFlightLogsIds length are not equal');
    }
  }

  ///
  /// UPDATE NEW SHIFT FLIGHT LOGS
  ///
  void updateNewShiftFlightLogs({
    List<FlightLogModel> givenLogs = const [],
    List<int> idsForReload = const [],
  }) {
    try {
      if (
        (newShiftFlightLogsIds.isEmpty && newShiftFlightLogs.isNotEmpty) ||
        (newShiftFlightLogsIds.isNotEmpty && newShiftFlightLogs.isEmpty)
      ) {
        throw Error();
      }

      if (newShiftFlightLogsIds.isEmpty) {
        newShiftFlightLogs = givenLogs;
        newShiftFlightLogsIds = givenLogs.map((log) => log.id).toList();
      } else {
        /// check to avoid inserting a duplicate flight log
        for (final log in givenLogs) {
          bool isDuplicate = newShiftFlightLogsIds.contains(log.id);
          print('[updateNewShiftFlightLogs] isDuplicate - $isDuplicate');
          if (!isDuplicate) {
            newShiftFlightLogs.add(log);
            newShiftFlightLogsIds.add(log.id);
          }

          bool isDuplicate2 = newShiftFlightLogs.any((existingLog) {
            print('[updateNewShiftFlightLogs] existingLog.id - ${existingLog.id}, log.id - ${log.id}');
            return existingLog.id == log.id;
          });
          print('[updateNewShiftFlightLogs] isDuplicate2 - $isDuplicate2');
          if (!isDuplicate2) {
            newShiftFlightLogs.add(log);
            newShiftFlightLogsIds.add(log.id);
          }
        }
      }
    } catch (e) {
      print('[ERR]: newShiftFlightLogs and newShiftFlightLogsIds length are not equal');
      print('       newShiftFlightLogsIds.length - ${newShiftFlightLogsIds.length}, newShiftFlightLogs.length - ${newShiftFlightLogs.length}');
    }
  }

  ///
  /// UPDATE SHIFTS
  ///
  void updateShifts(List<ShiftModel> givenShifts) {
  // void updateShifts(List<ShiftModel> givenShifts, { int? shiftsTotalCount }) {
    try {
      // WORK ==============================
      // shiftsTotalCount -= 1;
      // shiftsTotalCountArr.first = shiftsTotalCount - 1;

      // shiftsTotalCou.value -= 1;
 
      // shiftsTotalCountArr.first = shiftsTotalCountArr.first - 1;

      // print('[updateShifts] ........... shiftsTotalCount - $shiftsTotalCount');
      // print('[updateShifts] ........... shiftsTotalCountArr.first - ${shiftsTotalCountArr.first}');

      if (
        (shiftsIds.isEmpty && shifts.isNotEmpty) ||
        (shiftsIds.isNotEmpty && shifts.isEmpty)
      ) {
        throw Error();
      }

      if (shiftsIds.isEmpty) {
        shifts = givenShifts;
        shiftsIds = givenShifts.map((shift) => shift.id).toList();
      } else {
        // print('shiftsIds.length - ${shiftsIds.length}');
        /// check to avoid inserting a duplicate shift
        for (final shift in givenShifts) {
          bool isDuplicate = shiftsIds.contains(shift.id);
          // print('isDuplicate - $isDuplicate');
          // if (isDuplicate) {
          //   print('duplicate id - ${shift.id}');
          // }
          if (!isDuplicate) {
            shifts.add(shift);
            shiftsIds.add(shift.id);
          }
        }
      }

      // if (shiftsTotalCount != null) {
      //   shiftsTotalCou.value = shiftsTotalCount;
      // }
    } catch (e) {
      print('[ERR]: shifts and shiftsIds length are not equal');
    }
  }


  void updateShiftsRes(ShiftsResult givenShiftsRes) {
    try {
      if (
        (shiftsIds.isEmpty && shiftsRes.shifts.isNotEmpty) ||
        (shiftsIds.isNotEmpty && shiftsRes.shifts.isEmpty)
      ) {
        throw Error();
      }

      print('[updateShiftsRes]: givenShiftsRes.shifts - ${givenShiftsRes.shifts}');
      print('[updateShiftsRes]: givenShiftsRes.totalCount - ${givenShiftsRes.totalCount}');

      if (shiftsIds.isEmpty) {
        shiftsRes.shifts = givenShiftsRes.shifts;
        shiftsRes.totalCount = givenShiftsRes.totalCount;
        shiftsIds = givenShiftsRes.shifts.map((shift) => shift.id).toList();
      } else {
        shiftsRes.totalCount = givenShiftsRes.totalCount;

        // print('shiftsIds.length - ${shiftsIds.length}');
        /// check to avoid inserting a duplicate shift
        for (final shift in givenShiftsRes.shifts) {
          bool isDuplicate = shiftsIds.contains(shift.id);
          // print('isDuplicate - $isDuplicate');
          // if (isDuplicate) {
          //   print('duplicate id - ${shift.id}');
          // }
          if (!isDuplicate) {
            shiftsRes.shifts.add(shift);
            shiftsIds.add(shift.id);
          }
        }
      }

      // if (shiftsTotalCount != null) {
      //   shiftsTotalCou.value = shiftsTotalCount;
      // }
    } catch (e) {
      print('[ERR]: shifts and shiftsIds length are not equal');
    }
  }


















  ///
  ///
  ///
  
  // void updateShiftsTotalCount(int count) => shiftsTotalCount = count;
  // void updateShiftsTotalCount(int count) => shiftsTotalCou['value'] = count;
  // void updateShiftsTotalCount(int count) => shiftsTotalCou.value = count;
  // void updateShiftsTotalCount(int count) => shiftsTotalCountArr.first = count;

  // void updateShiftsTotalCou(int count) => shiftsTotalCou.value = count;
  // void updateShiftsTotalCouInit(int count) {
  //   shiftsTotalCouInit.value = count;
  //   shiftsTotalCou.value = count;
  // }

  void resetShifts() {
    shifts = [];
    shiftsIds = [];
  }

  void replaceShift(ShiftModel givenShift) {
    int index = shifts.indexWhere((shift) => shift.id == givenShift.id);

    if (index != -1) {
      shifts.fillRange(index, index + 1, givenShift);
    }
  }

  bool removeShift(int id) {
    // int beforeCount = shifts.length;
    // shifts.removeWhere((shift) => shift.id == id);
    // int afterCount = shifts.length;

    // return beforeCount != afterCount;

    int beforeCount = shiftsRes.shifts.length;
    shiftsRes.shifts.removeWhere((shift) => shift.id == id);
    int afterCount = shiftsRes.shifts.length;

    print('[removeShift]: shift id $id');
    if (beforeCount != afterCount) {
      print('[removeShift]: shift with id $id has been removed');
    }
    return beforeCount != afterCount;
  }

  ///
  ///
  ///
  void setSingleShiftMode(ShiftModel shift) {
    isSingleShiftMode = true;
    singleShift = shift;
  }
  void resetSingleShiftMode() {
    isSingleShiftMode = false;
    singleShift = null;
    resetSingleShiftFlightLogs();
    /// update() is not needed because it leads to reloading of FlightLogs (which is being closed at the moment),
    /// so updateSingleShiftFlightLogs is called and enters <if (singleShiftFlightLogsIds.isEmpty)> block,
    /// and single shift mode is set again
    // update();
  }

  void resetSingleShiftFlightLogs() {
    singleShiftFlightLogs = [];
    singleShiftFlightLogsIds = [];
  }

  void replaceSingleShiftFlightLog(FlightLogModel givenLog) {
    int index = singleShiftFlightLogs.indexWhere((log) => log.id == givenLog.id);

    if (index != -1) {
      singleShiftFlightLogs.fillRange(index, index + 1, givenLog);
    }
  }

  ///
  ///
  ///
  void resetFlightLogs() {
    flightLogs = [];
    flightLogsIds = [];
  }
  
  void replaceFlightLog(FlightLogModel givenLog) {
    int index = flightLogs.indexWhere((log) => log.id == givenLog.id);
    print('[replaceFlightLog] index - $index, flightLogs.length - ${flightLogs.length}');
    if (index != -1) {
      flightLogs.fillRange(index, index + 1, givenLog);
    }
  }

  bool removeFlightLog(int id) {
    int beforeCount = flightLogs.length;
    flightLogs.removeWhere((log) => log.id == id);
    int afterCount = flightLogs.length;

    return beforeCount != afterCount;
  }

  ///
  ///
  ///
  void resetNewShiftFlightLogs() {
    newShiftFlightLogs = [];
    newShiftFlightLogsIds = [];
  }

  void replaceNewShiftFlightLog(FlightLogModel givenLog) {
    int index = newShiftFlightLogs.indexWhere((log) => log.id == givenLog.id);

    if (index != -1) {
      newShiftFlightLogs.fillRange(index, index + 1, givenLog);
    }
  }






















  bool hasShiftsSelectionEnded = false;

  void updateSelectedShifts(DateTime from, DateTime to) {
    selectedShifts = filterShifts(from, to, shifts);
    hasShiftsSelectionEnded = true;
  }

  void resetShiftsSelection() {
    hasShiftsSelectionEnded = false;
    // print('resetShiftsSelection');
  }

  // NewShiftModel? newShift;
  // ShiftModel? newShift;
  var newShiftId = -1;

  void setNewShiftId(int id) async {
    newShiftId = id;
  }

  void removeNewShiftId() {
    newShiftId = -1;
  }


















  // Future<void> insertDog(Dog dog, Future<Database> database) async {
  //   // Get a reference to the database.
  //   final db = await database;

  //   // Insert the Dog into the correct table. You might also specify the
  //   // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //   //
  //   // In this case, replace any previous data.
  //   await db.insert(
  //     'dogs',
  //     dog.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  // Future<List<Dog>> dogs(Future<Database> database) async {
  //   // Get a reference to the database.
  //   final db = await database;

  //   // Query the table for all the dogs.
  //   final List<Map<String, Object?>> dogMaps = await db.query('dogs');

  //   // Convert the list of each dog's fields into a list of `Dog` objects.
  //   return [
  //     for (final {
  //           'id': id as int,
  //           'name': name as String,
  //           'age': age as int,
  //         } in dogMaps)
  //       Dog(id: id, name: name, age: age),
  //   ];
  // }







































  ///
  /// Home block
  ///
  int topFlightTimeMinutes = 0;
  int topDistanceMeters = 0;
  int topAltitudeMeters = 0;
  int lastShiftId = -1;
  /// TODO: last flight log means 'last added log' but on home page
  /// there should be last flight log in the meaning of 'the latest flight'.
  /// SOLUTION:
  /// 1. In db make table FlightLogLandingRecord
  /// where a unit is <FlightLogLandingRecord> { id: logId, landingDateAndTime, landingDateAndTimeMs }
  /// 2. added or edited log --> if > last in table --> add to end in table
  ///                            if < last in table --> find by landingDateAndTimeMs where to insert in table
  /// DO NOT IMPLEMENT BEC. EDITING LAST LOG SO THAT IT BECOMES NOT LATEST IS A RARE CASE
  ///                    OR EDITING OTHER LOG SO THAT IT BECOMES LATEST IS A RARE CASE TOO
  /// IF TO IMPLEMENT IT WOULD BE EXPENSIVE SOLUTION WITH TRACKING INDEXES,
  /// HANDLING DUPLICATES IN ms, REWRITING INDEXES OF MANY ITEMS ETC.
  /// 
  /// POSSIBLE SOLUTION: better to make a func which searches a real latest log in db (orderBy),
  /// and call it, and show spinner while waiting of updating Last flight field on Home page.
  int lastFlightLogId = -1;
  FlightLogModel lastFlightLog = FlightLogModel(shiftId: -1, id: -1);

  void updateTopFlightTime(int time) => topFlightTimeMinutes = time;
  void updateTopDistance(int distance) => topDistanceMeters = distance;
  void updateTopAltitude(int altitude) => topAltitudeMeters = altitude;
  void updateLastShiftId(int id) => lastShiftId = id;
  void updateLastFlightLogId(int id) => lastFlightLogId = id;
  void updateLastFlightLog(FlightLogModel log) => lastFlightLog = log;
  // void updateLastFlightLogs(List<FlightLogModel> logs) => lastFlightLogs = logs;

  // void onInit() {
  //   updateTopFlightTime(initData.topFlightTimeMinutes);
  //   updateTopDistance(initData.topDistanceMeters);
  //   updateTopAltitude(initData.topAltitudeMeters);
  //   updateLastShiftId(initData.lastShiftId);
  //   updateLastFlightLogId(initData.lastFlightLog.id);
  //   updateLastFlightLog(initData.lastFlightLog);
  //   updateLastFlightLogs(initData.lastFlightLogs);
  // }


















  // ------------
  // void addNewShiftFlightLog(BaseFlightLogModel flightLog) async {
  // }

  // ------------
  // FlightLogModel? getFlightLogById(String id) {
  //   var log = flightLogs.firstWhere((log) => log.id == id, orElse: () => null);
  //   return log;
  // }

  // ------------
  // FlightLogModel? getFlightLogById(String id, {bool isNewShift = false}) {
  //   try {
  //     if (isNewShift) {
  //       FlightLogModel? log = newShift?.logs.firstWhere((log) => log.id == id);
  //       return log;
  //     } else {
  //       FlightLogModel log = flightLogs.firstWhere((log) => log.id == id);
  //       return log;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // ------------
  // NewShiftFlightLogModel? getNewShiftFlightLogById(String id) {
  //   try {
  //     NewShiftFlightLogModel log = newShift!.logs.firstWhere((log) => log.id == id);
  //     return log;
  //   } catch (e) {
  //     return null;
  //   }
  // }
  // ------------
  // FlightLogModel? findLastFlightLog() {
  //   List<String> dateAndTimes = [];

  //   for (final FlightLogModel(:landingDateAndTime) in flightLogs) {
  //     dateAndTimes.add(landingDateAndTime);
  //   }

  //   int lastFlightLogIndex = getLastDateAndTimeIndex(dateAndTimes);
  //   lastFlightLog = flightLogs[lastFlightLogIndex];

  //   return lastFlightLog;
  // }

  // ------------
  // void updateFlightLog(FlightLogModel log, {bool isNewShift = false}) {
  //   final existingLog = getFlightLogById(log.id, isNewShift: isNewShift);

  //   if (existingLog != null) {
  //     existingLog.takeoffDateAndTime = log.takeoffDateAndTime;
  //     existingLog.landingDateAndTime = log.landingDateAndTime;
  //     existingLog.flightTimeMinutes = log.flightTimeMinutes;
  //     existingLog.distanceMeters = log.distanceMeters;
  //     existingLog.altitudeMeters = log.altitudeMeters;
  //     existingLog.location = log.location;
  //     existingLog.droneAccum = log.droneAccum;
  //     existingLog.droneAccumChargeLeft = log.droneAccumChargeLeft;
  //     existingLog.rcAccumChargeLeft = log.rcAccumChargeLeft;
  //     // var ind = flightLogs.indexOf(existingLog);
  //     // print(ind);

  //     // var x = existingLog.toString();
  //     // print('stringified: $x');
  //     // appStorage.write(x);      
  //   }
  // }

  // ------------
  // void updateNewShiftFlightLog(BaseFlightLogModel log, String id) {
  //   final newShiftLog = getNewShiftFlightLogById(id);

  //   if (newShiftLog != null) {
  //     var l = getUpdatedFlightLog(newShiftLog, log);
  //     // TD: update log in db in newShift
  //   }
  // }

  // Shift? lastShift;


















  ///
  ///
  ///
  FlightLogModel? getFlightLogById(int id) {
    try {
      FlightLogModel log = flightLogs.firstWhere((log) => log.id == id);
      return log;
    } catch (e) {
      return null;
    }
  }

  ///
  ///
  ///
  FlightLogModel getLastFlightLog() => lastFlightLog;

  ///
  ///
  ///
  FlightLogModel? setLastFlightLog() {
    if (flightLogs.isNotEmpty) {
      lastFlightLog = flightLogs[flightLogs.length - 1];
    }

    return lastFlightLog;
  }

  ///
  ///
  /// TODO: make similar func findLastShift (probably without logs parameter)
  FlightLogModel? findLastFlightLog(List<FlightLogModel>? logs) {
    List<String> dateAndTimes = [];
    List<FlightLogModel> targetLogs = logs ?? flightLogs;

    for (final FlightLogModel(:landingDateAndTime) in targetLogs) {
      dateAndTimes.add(landingDateAndTime);
    }

    int lastFlightLogIndex = getLastDateAndTimeIndex(dateAndTimes);
    lastFlightLog = targetLogs[lastFlightLogIndex];

    return lastFlightLog;
  }

  ///
  ///
  ///
  BaseFlightLogModel getUpdatedFlightLog(BaseFlightLogModel oldLog, BaseFlightLogModel newLog) {
    oldLog.takeoffDateAndTime = newLog.takeoffDateAndTime;
    oldLog.landingDateAndTime = newLog.landingDateAndTime;
    oldLog.flightTimeMinutes = newLog.flightTimeMinutes;
    oldLog.distanceMeters = newLog.distanceMeters;
    oldLog.altitudeMeters = newLog.altitudeMeters;
    oldLog.location = newLog.location;
    oldLog.droneAccum = newLog.droneAccum;
    oldLog.droneAccumChargeLeft = newLog.droneAccumChargeLeft;
    oldLog.rcAccumChargeLeft = newLog.rcAccumChargeLeft;

    return oldLog;
  }

  ///
  ///
  ///
  void updateFlightLog(BaseFlightLogModel log, int id) {
    final existingLog = getFlightLogById(id);

    if (existingLog != null) {
      // var l = getUpdatedFlightLog(existingLog, log);
      // TODO: update log in db
    }
  }


  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  ///
  ///
  ///
  void dbUpdateHomeInDb() async {
    HomeModel home = await getHomeFromDb();
    List<ShiftModel> shifts = (await getShiftsFromDb()).shifts;
    List<FlightLogModel> logs = await getFlightLogsFromDb();

    bool shouldUpdateTopFlightTimeMinutes = false;
    bool shouldUpdateTopDistanceMeters = false;
    bool shouldUpdateTopAltitudeMeters = false;
    bool shouldUpdateLastShiftId = false;
    bool shouldUpdateLastFlightLogId = false;

    for (final log in logs) {
      if (log.flightTimeMinutes > topFlightTimeMinutes) {
        updateTopFlightTime(log.flightTimeMinutes);
        shouldUpdateTopFlightTimeMinutes = true;
      }

      if (log.distanceMeters > topDistanceMeters) {
        updateTopDistance(log.distanceMeters);
        shouldUpdateTopDistanceMeters = true;
      }

      if (log.altitudeMeters > topAltitudeMeters) {
        updateTopAltitude(log.altitudeMeters);
        shouldUpdateTopAltitudeMeters = true;
        print('[dbUpdateHomeInDbAfterShiftRemoved] topAltitudeMeters - $topAltitudeMeters, log.altitudeMeters - ${log.altitudeMeters}, log.id - ${log.id}');
      }
    }

    if (shifts.isNotEmpty) {
      int lastShiftId = shifts.elementAt(shifts.length - 1).id;

      if (home.lastShiftId != lastShiftId) {
        updateLastShiftId(lastShiftId);
        shouldUpdateLastShiftId = true;
      }
    }

    if (logs.isNotEmpty) {
      int lastFlightLogId = logs.elementAt(logs.length - 1).id;
      print('[dbUpdateHomeInDbAfterShiftRemoved]: home.lastFlightLogId - ${home.lastFlightLogId}, last log\'s id - $lastFlightLogId');

      if (home.lastFlightLogId != lastFlightLogId) {
        updateLastFlightLogId(lastFlightLogId);
        shouldUpdateLastFlightLogId = true;
      }
    }

    updateHomeInDb(
      topFlightTimeMinutes: shouldUpdateTopFlightTimeMinutes
        ? topFlightTimeMinutes
        : null,
      topDistanceMeters: shouldUpdateTopDistanceMeters
        ? topDistanceMeters
        : null,
      topAltitudeMeters: shouldUpdateTopAltitudeMeters
        ? topAltitudeMeters
        : null,
      lastShiftId: shouldUpdateLastShiftId
        ? lastShiftId
        : null,
      lastFlightLogId: shouldUpdateLastFlightLogId
        ? lastFlightLogId
        : null,
    );
  }

  ///
  ///
  ///
  Future<List<FlightLogModel>> dbGetFlightLogs() async {
    List<FlightLogModel> logs = await getFlightLogsFromDb();
    print('[dbGetFlightLogs] ...getting all flight logs, count - ${logs.length}');

    // updateFlightLogs(logs, FlightLogOriginType.noShift);
    updateFlightLogs(givenLogs: logs);

    return logs;
  }

  ///
  ///
  ///
  Future<void> dbAddFlightLog(BaseFlightLogModel flightLog) async {
    int id = await addFlightLogToDb(flightLog);
    print('[dbAddFlightLog] id of created log: $id');
    FlightLogModel? log = await getFlightLogFromDb(id);

    if (log != null) {
      updateShiftInDb(log.shiftId, log, null);

      print('[dbAddFlightLog] log.shiftId - ${log.shiftId}, lastShiftId - $lastShiftId');
      if (log.shiftId == lastShiftId) {
        // newShiftFlightLogs.add(log);
        // newShiftFlightLogsIds.add(log.id);
        updateNewShiftFlightLogs(givenLogs: [log]);
      }

      _updateHomeInDbAndRefresh(log, true);
    }
  }

  ///
  ///
  ///
  Future<void> dbUpdateFlightLog(BaseFlightLogModel flightLog, int logId) async {
    FlightLogModel? logBeforeUpdate = await getFlightLogFromDb(logId);

    int changesMade = await updateFlightLogInDb(logId, flightLog);
    print('[dbUpdateFlightLog] changes made: $changesMade');

    if (changesMade > 0) {
      FlightLogModel log = flightLog.toLog(id: logId);

      await updateShiftInDb(log.shiftId, log, logBeforeUpdate);

      /// TODO: wrap into single function replaceItem
      replaceFlightLog(log);
      replaceSingleShiftFlightLog(log);
      replaceNewShiftFlightLog(log);

      // if (flightLog.shiftId == lastShiftId) {
        // int index = newShiftFlightLogs.indexWhere((log) => log.id == logId);

        // if (index != -1) {
        //   newShiftFlightLogs.fillRange(index, index + 1, log);
        // }
      // }

                              // if (flightLogsIds.contains(logId)) {
                              //   replaceFlightLog(log);
                              // }

                              // if (singleShiftFlightLogsIds.contains(logId)) {
                              //   replaceSingleShiftFlightLog(log);
                              // }

                              // if (newShiftFlightLogsIds.contains(logId)) {
                              //   replaceNewShiftFlightLog(log);
                              // }

      /// NB: this also notifies subscribers about changes in lastFlightLogs - NOT ACTUAL COMMENTARY
      await _updateHomeInDbAndRefresh(log, false);
    }
  }

  ///
  ///
  ///
  Future<void> _updateHomeInDbAndRefresh(FlightLogModel log, bool isNewLog) async {
    bool shouldUpdateTopFlightTime = log.flightTimeMinutes > topFlightTimeMinutes;
    bool shouldUpdateTopDistance = log.distanceMeters > topDistanceMeters;
    bool shouldUpdateTopAltitude = log.altitudeMeters > topAltitudeMeters;
    print('[_updateHomeInDbAndRefresh] log.shiftId - ${log.shiftId}, lastShiftId - $lastShiftId');
    bool shouldUpdateLastShiftId = log.shiftId != lastShiftId;

    await updateHomeInDb(
      topFlightTimeMinutes: shouldUpdateTopFlightTime
        ? log.flightTimeMinutes
        : null,
      topDistanceMeters: shouldUpdateTopDistance
        ? log.distanceMeters
        : null,
      topAltitudeMeters: shouldUpdateTopAltitude
        ? log.altitudeMeters
        : null,
      lastShiftId: shouldUpdateLastShiftId
        ? log.shiftId
        : null,
      lastFlightLogId: isNewLog
        ? log.id
        : null,
    );

    if (shouldUpdateTopFlightTime) {
      updateTopFlightTime(log.flightTimeMinutes);
    }

    if (shouldUpdateTopDistance) {
      updateTopDistance(log.distanceMeters);
    }

    if (shouldUpdateTopAltitude) {
      print('[_updateHomeInDbAndRefresh] changing top altitude to ${log.altitudeMeters}');
      updateTopAltitude(log.altitudeMeters);
    }

    if (shouldUpdateLastShiftId) {
      updateLastShiftId(log.shiftId);
    }

    if (isNewLog) {
      updateLastFlightLogId(log.id);
    }

    print('[_updateHomeInDbAndRefresh] log.id - ${log.id}, lastFlightLogId - $lastFlightLogId');

    if (isNewLog || log.id == lastFlightLogId) {
      updateLastFlightLog(log);
    }

    // update();
  }

  ///
  ///
  ///
  Future<bool> dbRemoveFlightLog(int id, int shiftId) async {
    bool isRemoved = await removeFlightLogFromDb(id);
    print('[dbRemoveFlightLog] is removed - $isRemoved, flightLogs.length - ${flightLogs.length}');

    if (isRemoved) {
      removeFlightLog(id);
      dbUpdateShiftAfterFlightLogRemoved(shiftId, id);
      dbUpdateHomeInDb();
    }

    return isRemoved;
  }

  ///
  ///
  ///
  Future<void> dbUpdateShiftAfterFlightLogRemoved(int shiftId, int removedLogId) async {
    ShiftModel? shift = await getShiftFromDb(shiftId);

    if (shift != null) {
      shift.logIds.retainWhere((id) => id != removedLogId);

      if (shift.logIds.isEmpty) {
        bool isRemoved = await removeShiftFromDb(shiftId);
        print('[dbUpdateShiftAfterFlightLogRemoved] ...removing shift - $isRemoved, id was - $shiftId'); 
      } else {
        int flightsQty = shift.logIds.length;
        int timeTotalMinutes = 0;
        int longestFlightTimeMinutes = 0;
        int longestDistanceMeters = 0;
        int highestAltitudeMeters = 0;

        for (final id in shift.logIds) {
          final log = await getFlightLogFromDb(id);

          if (log != null) {
            timeTotalMinutes += log.flightTimeMinutes;

            if (log.flightTimeMinutes > longestFlightTimeMinutes) {
              longestFlightTimeMinutes = log.flightTimeMinutes;
            }

            if (log.distanceMeters > longestDistanceMeters) {
              longestDistanceMeters = log.distanceMeters;
            }

            if (log.altitudeMeters > highestAltitudeMeters) {
              highestAltitudeMeters = log.altitudeMeters;
            }

            /// TODO: update startedAtDateAndTime and endedAtDateAndTime
          }
        }

        shift.flightsQty = flightsQty;
        shift.timeTotalMinutes = timeTotalMinutes;
        shift.longestFlightTimeMinutes = longestFlightTimeMinutes;
        shift.longestDistanceMeters = longestDistanceMeters;
        shift.highestAltitudeMeters = highestAltitudeMeters;

        await updateShiftInDbAfterFlightLogRemoved(shift);
      }   
    }
  }

  ///
  ///
  ///
  Future<ShiftModel?> dbGetShift(int id) async {
    ShiftModel? shift = await getShiftFromDb(id);

    return shift;
  }

  ///
  ///
  ///
  Future<bool> dbRemoveShift(int id) async {
    bool isRemoved = await removeShiftFromDb(id);
    print('[dbRemoveShift] is removed - $isRemoved, was id - $id, shifts.length - ${shifts.length}');

    if (isRemoved) {
      removeShift(id);
      dbUpdateHomeInDb();
    }

    return isRemoved;
  }































  ///
  ///
  ///
  void update() {
    notifyListeners();
  }
}






















// class Dog {
//   final int id;
//   final String name;
//   final int age;

//   Dog({
//     required this.id,
//     required this.name,
//     required this.age,
//   });

//   // Convert a Dog into a Map. The keys must correspond to the names of the
//   // columns in the database.
//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'age': age,
//     };
//   }

//   // Implement toString to make it easier to see information about
//   // each dog when using the print statement.
//   @override
//   String toString() {
//     return 'Dog{id: $id, name: $name, age: $age}';
//   }
// }
