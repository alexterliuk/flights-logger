// ======= paste to https://dartpad.dev =======
// void main() {
//   DateTime date = DateTime.parse('1969-07-20 20:18Z'); // when Z given it is UTC format
//   print(date.toString());
//   print(date.isUtc);
// }

///
/// Base flight log class
/// Also used for passing as an argument to addFlightLogToDb
///
class BaseFlightLogModel {
  String takeoffDateAndTime; // '2024-07-20 23:48'
  String landingDateAndTime; // '2024-07-21 00:07'
  int flightTimeMinutes;
  int distanceMeters;
  int altitudeMeters;
  String location;
  String droneAccum;
  int droneAccumChargeLeft;
  int rcAccumChargeLeft;
  int shiftId;

  BaseFlightLogModel({
    this.takeoffDateAndTime = '',
    this.landingDateAndTime = '',
    this.flightTimeMinutes = -1,
    this.distanceMeters = -1,
    this.altitudeMeters = -1,
    this.location = '',
    this.droneAccum = '',
    this.droneAccumChargeLeft = -1,
    this.rcAccumChargeLeft = -1,
    required this.shiftId,
  });

  Map<String, Object?> toMap() {
    return {
      'takeoffDateAndTime': takeoffDateAndTime,
      'landingDateAndTime': landingDateAndTime,
      'flightTimeMinutes': flightTimeMinutes,
      'distanceMeters': distanceMeters,
      'altitudeMeters': altitudeMeters,
      'location': location,
      'droneAccum': droneAccum,
      'droneAccumChargeLeft': droneAccumChargeLeft,
      'rcAccumChargeLeft': rcAccumChargeLeft,
      'shiftId': shiftId,
    };
  }

  FlightLogModel toLog({ required int id }) {
    return FlightLogModel(
      takeoffDateAndTime: takeoffDateAndTime,
      landingDateAndTime: landingDateAndTime,
      flightTimeMinutes: flightTimeMinutes,
      distanceMeters: distanceMeters,
      altitudeMeters: altitudeMeters,
      location: location,
      droneAccum: droneAccum,
      droneAccumChargeLeft: droneAccumChargeLeft,
      rcAccumChargeLeft: rcAccumChargeLeft,
      shiftId: shiftId,
      id: id,
    );
  }
}

///
/// A log is stored in db table FlightLog
///
class FlightLogModel extends BaseFlightLogModel {
  final int id;

  FlightLogModel({
    super.takeoffDateAndTime,
    super.landingDateAndTime,
    super.flightTimeMinutes,
    super.distanceMeters,
    super.altitudeMeters,
    super.location,
    super.droneAccum,
    super.droneAccumChargeLeft,
    super.rcAccumChargeLeft,
    required super.shiftId,
    required this.id,
  });
}
