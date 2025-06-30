List<String> initialTableQueries = [
'''
CREATE TABLE FlightLog(
  droneName TEXT,
  droneId TEXT,
  id INTEGER PRIMARY KEY,
  takeoffDateAndTime TEXT,
  landingDateAndTime TEXT,
  flightTimeMinutes INTEGER,
  distanceMeters INTEGER,
  altitudeMeters INTEGER,
  location TEXT,
  droneAccum TEXT,
  droneAccumChargeLeft INTEGER,
  rcAccumChargeLeft INTEGER,
  note TEXT,
  shiftId INTEGER
)
''',
'''
CREATE TABLE Shift(
  id INTEGER PRIMARY KEY,
  logIds TEXT,
  startedAtDateAndTime TEXT,
  endedAtDateAndTime TEXT,
  flightsQty INTEGER,
  timeTotalMinutes INTEGER,
  longestFlightTimeMinutes INTEGER,
  longestDistanceMeters INTEGER,
  highestAltitudeMeters INTEGER
)
''',
'''
CREATE TABLE Home(
  topFlightTimeMinutes INTEGER,
  topDistanceMeters INTEGER,
  topAltitudeMeters INTEGER,
  lastFlightLogId INTEGER,
  lastShiftId INTEGER
)
''',
];
