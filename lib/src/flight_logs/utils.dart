import '../shifts/shift_model.dart';

bool hasLogIdsChanged(List<int> originalIds, List<int> editedIds) {
  if (originalIds.length != editedIds.length) {
    return true;
  }

  List<bool> changes = originalIds.map((origId) => !editedIds.contains(origId)).toList();

  return changes.any((change) => change == true);
}

bool hasShiftChanged(ShiftModel originalShift, ShiftModel editedShift) {
  List<bool> changes = [
    hasLogIdsChanged(originalShift.logIds, editedShift.logIds),
    originalShift.startedAtDateAndTime != editedShift.startedAtDateAndTime,
    originalShift.endedAtDateAndTime != editedShift.endedAtDateAndTime,
    originalShift.flightsQty != editedShift.flightsQty,
    originalShift.timeTotalMinutes != editedShift.timeTotalMinutes,
    originalShift.longestFlightTimeMinutes != editedShift.longestFlightTimeMinutes,
    originalShift.longestDistanceMeters != editedShift.longestDistanceMeters,
    originalShift.highestAltitudeMeters != editedShift.highestAltitudeMeters,
  ];

  return changes.any((change) => change == true);
}
