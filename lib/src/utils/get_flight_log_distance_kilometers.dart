String getFlightLogDistanceKilometers(int distanceMeters) {
  if (distanceMeters == 0 || distanceMeters == -1) {
    return '-';
  }

  var distanceKm = (distanceMeters / 1000).toStringAsFixed(1);

  if (distanceKm.endsWith('0')) {
    distanceKm = distanceKm.substring(0, distanceKm.length - 2);
  }

  if (distanceKm == '0') {
    distanceKm = '0,1';
  }

  if (distanceKm.contains('.')) {
    distanceKm = distanceKm.splitMapJoin('.', onMatch: (s) => ',');
  }

  return '$distanceKm km';
}
