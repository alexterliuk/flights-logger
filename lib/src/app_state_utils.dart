import 'app_state.dart';
import 'db/queries.dart';
import 'home/home_model.dart';
import 'shifts/shift_model.dart';
import 'flight_logs/flight_log_model.dart';

bool resetAppState(MyAppState appState) {
  try {
    appState.currentPage = '';
    appState.history = [];
    appState.isSingleShiftMode = false;
    appState.singleShift = null;
    appState.isSelectedShiftsMode = false;
    appState.selectShiftsFromDate = null;
    appState.selectShiftsToDate = null;
    appState.flightLogs = [];
    appState.flightLogsIds = [];
    appState.singleShiftFlightLogs = [];
    appState.singleShiftFlightLogsIds = [];
    appState.newShiftFlightLogs = [];
    appState.newShiftFlightLogsIds = [];
    appState.shiftsRes = ShiftsResult(shifts: []);
    appState.shiftsIds = [];
    appState.topFlightTimeMinutes = 0;
    appState.topDistanceMeters = 0;
    appState.topAltitudeMeters = 0;
    appState.lastShiftId = -1;
    appState.lastFlightLogId = -1;
    appState.lastFlightLog = FlightLogModel(shiftId: -1, id: -1);

    return true;
  } catch (err) {
    return false;
  }
}

bool setAppState(
  MyAppState appState,
  HomeModel home,
  List<ShiftModel> shifts,
  List<FlightLogModel> logs,
) {
  try {
    appState.flightLogs = logs;
    appState.flightLogsIds = []; // TODO;
    appState.shiftsRes = ShiftsResult(shifts: shifts);
    appState.shiftsIds = []; // TODO;
    appState.topFlightTimeMinutes = home.topFlightTimeMinutes;
    appState.topDistanceMeters = home.topDistanceMeters;
    appState.topAltitudeMeters = home.topAltitudeMeters;
    appState.lastShiftId = home.lastShiftId;
    appState.lastFlightLogId = home.lastFlightLogId;
    appState.lastFlightLog = FlightLogModel(shiftId: -1, id: -1); // TODO;

    return true;
  } catch (err) {
    return false;
  }
}
