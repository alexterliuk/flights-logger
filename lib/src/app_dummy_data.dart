import 'flight_logs/flight_log_model.dart';
import 'shifts/shift_model.dart';

// ============================= FLIGHT LOGS =============================

final dummyFlightLogs = <FlightLogModel>[
  FlightLogModel(
    id: 101,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-11 08:34',
    landingDateAndTime: '2024-07-11 08:57',
    flightTimeMinutes: 23,
    distanceMeters: 5389,
    altitudeMeters: 274,
    location: '265-267',
    droneAccum: '01K5',
    droneAccumChargeLeft: 19,
    rcAccumChargeLeft: 91,
  ),
  FlightLogModel(
    id: 102,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-11 09:51',
    landingDateAndTime: '2024-07-11 10:12',
    flightTimeMinutes: 21,
    distanceMeters: 6154,
    altitudeMeters: 389,
    location: '264-267',
    droneAccum: 'BRCC',
    droneAccumChargeLeft: 23,
    rcAccumChargeLeft: 89,
  ),
  FlightLogModel(
    id: 103,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-12 10:47',
    landingDateAndTime: '2024-07-12 11:03',
    flightTimeMinutes: 16,
    distanceMeters: 4259,
    altitudeMeters: 157,
    location: '265-267',
    droneAccum: 'OZMW',
    droneAccumChargeLeft: 44,
    rcAccumChargeLeft: 81,
  ),
  FlightLogModel(
    id: 104,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-12 08:11',
    landingDateAndTime: '2024-07-12 08:39',
    flightTimeMinutes: 28,
    distanceMeters: 9785,
    altitudeMeters: 353,
    location: '264-267',
    droneAccum: 'H93K',
    droneAccumChargeLeft: 16,
    rcAccumChargeLeft: 88,
  ),  
  FlightLogModel(
    id: 105,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-12 09:29',
    landingDateAndTime: '2024-07-12 09:48',
    flightTimeMinutes: 19,
    distanceMeters: 5118,
    altitudeMeters: 250,
    location: '263-266',
    droneAccum: 'BRCC',
    droneAccumChargeLeft: 39,
    rcAccumChargeLeft: 94,
  ),
  FlightLogModel(
    id: 106,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
  FlightLogModel(
    id: 107,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
  FlightLogModel(
    id: 108,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 109,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 110,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-11 18:01',
    landingDateAndTime: '2024-07-11 18:17',
    flightTimeMinutes: 16,
    distanceMeters: 111,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 111,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 112,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 113,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 114,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 115,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 116,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 117,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 118,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 119,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 120,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 121,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 122,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 123,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 124,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 125,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 126,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 127,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 128,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 129,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 130,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 131,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 132,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 133,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 134,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 135,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
    FlightLogModel(
    id: 136,
    shiftId: 111,
    takeoffDateAndTime: '2024-07-13 08:31',
    landingDateAndTime: '2024-07-13 08:44',
    flightTimeMinutes: 13,
    distanceMeters: 3521,
    altitudeMeters: 179,
    location: '265-266',
    droneAccum: '01K5',
    droneAccumChargeLeft: 72,
    rcAccumChargeLeft: 90,
  ),
];

// ============================= SHIFTS =============================

final dummyShifts = <ShiftModel>[
  ShiftModel(
    id: 1,
    logIds: [101, 102, 103],
    startedAtDateAndTime: '2024-07-11 08:34',
    endedAtDateAndTime: '2024-07-12 11:03',
    flightsQty: 12,
    timeTotalMinutes: 167,
    longestFlightTimeMinutes: 28,
    longestDistanceMeters: 9338,
    highestAltitudeMeters: 407,
  ),
  ShiftModel(
    id: 2,
    logIds: [104, 105],
    startedAtDateAndTime: '2024-07-12 08:11',
    endedAtDateAndTime: '2024-07-12 09:48',
    flightsQty: 10,
    timeTotalMinutes: 154,
    longestFlightTimeMinutes: 25,
    longestDistanceMeters: 8718,
    highestAltitudeMeters: 392,
  ),
  ShiftModel(
    id: 3,
    logIds: [106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120],
    startedAtDateAndTime: '2024-07-13 08:31',
    endedAtDateAndTime: '2024-07-13 08:44',
    flightsQty: 9,
    timeTotalMinutes: 139,
    longestFlightTimeMinutes: 27,
    longestDistanceMeters: 9952,
    highestAltitudeMeters: 431,
  ),
  ShiftModel(
    id: 4,
    logIds: [121, 122, 123, 124, 125, 126, 127],
    startedAtDateAndTime: '2024-07-13 08:31',
    endedAtDateAndTime: '2024-07-14 08:44',
    flightsQty: 9,
    timeTotalMinutes: 139,
    longestFlightTimeMinutes: 27,
    longestDistanceMeters: 9952,
    highestAltitudeMeters: 431,
  ),
  ShiftModel(
    id: 111,
    logIds: [121, 122, 123, 124, 125, 126, 127],
    startedAtDateAndTime: '2024-07-13 08:31',
    endedAtDateAndTime: '2024-07-14 08:44',
    flightsQty: 9,
    timeTotalMinutes: 139,
    longestFlightTimeMinutes: 27,
    longestDistanceMeters: 9952,
    highestAltitudeMeters: 431,
  ),
];
