import '../utils/date_time/get_date_string_without_time.dart';
import '../utils/date_time/is_valid_range.dart';
import './shift_model.dart';

List<ShiftModel> filterShifts (DateTime fromDate, DateTime toDate, List<ShiftModel> shifts) {
  List<ShiftModel> filteredShifts = shifts.where((shift) {
    return isShiftInRange(fromDate, toDate, shift);
  }).toList();

  return filteredShifts;
}

bool isShiftInRange(DateTime fromDate, DateTime toDate, ShiftModel shift) {
  try {
    // remove time as we compare only days
    String fromDateWithoutTime = getDateStringWithoutTimeFromDateTime(fromDate);
    String toDateWithoutTime = getDateStringWithoutTimeFromDateTime(toDate);
    DateTime from = DateTime.parse(fromDateWithoutTime);
    DateTime to = DateTime.parse(toDateWithoutTime);

    String shiftStartedAtDate = getDateStringWithoutTimeFromDateString(shift.startedAtDateAndTime);
    String shiftEndedAtDate = getDateStringWithoutTimeFromDateString(shift.endedAtDateAndTime);
    DateTime shiftStart = DateTime.parse(shiftStartedAtDate);
    DateTime shiftEnd = DateTime.parse(shiftEndedAtDate);

    if (!isValidRange(from, to)) {
      return false;
    }

    bool shiftStartedWithinRange = from.difference(shiftStart).inDays <= 0;
    bool shiftEndedWithinRange = to.difference(shiftEnd).inDays >= 0;

    if (shiftStartedWithinRange && shiftEndedWithinRange) {
      return true;
    }

    return false;
  } catch (e) {
    return false;
  }

}
