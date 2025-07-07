class BaseShiftModel {
  List<int> logIds;
  String startedAtDateAndTime; // '2024-07-20 08:13'
  String endedAtDateAndTime; // '2024-07-21 08:37'
  int flightsQty;
  int timeTotalMinutes;
  int longestFlightTimeMinutes;
  int longestDistanceMeters;
  int highestAltitudeMeters;

  BaseShiftModel({
    this.logIds = const [],
    this.startedAtDateAndTime = '',
    this.endedAtDateAndTime = '',
    this.flightsQty = 0,
    this.timeTotalMinutes = 0,
    this.longestFlightTimeMinutes = 0,
    this.longestDistanceMeters = 0,
    this.highestAltitudeMeters = 0,
  });

  Map<String, Object?> toMap() {
    return {
      'logIds': logIds.join(','),
      'startedAtDateAndTime': startedAtDateAndTime,
      'endedAtDateAndTime': endedAtDateAndTime,
      'flightsQty': flightsQty,
      'timeTotalMinutes': timeTotalMinutes,
      'longestFlightTimeMinutes': longestFlightTimeMinutes,
      'longestDistanceMeters': longestDistanceMeters,
      'highestAltitudeMeters': highestAltitudeMeters,
    };
  }
}

class ShiftModel extends BaseShiftModel {
  final int id;

  ShiftModel({
    super.logIds,
    super.startedAtDateAndTime = '',
    super.endedAtDateAndTime = '',
    super.flightsQty = 0,
    super.timeTotalMinutes = 0,
    super.longestFlightTimeMinutes = 0,
    super.longestDistanceMeters = 0,
    super.highestAltitudeMeters = 0,
    required this.id,    
  });
}
