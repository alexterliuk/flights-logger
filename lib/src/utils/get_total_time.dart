import '../utils/prepend_zero_if_needed.dart';

String getTotalTime(int totalMinutes) {
  if (totalMinutes < 60) {
    return '${totalMinutes}m';
  }

  int hours = (totalMinutes / 60).floor();
  int minutes = totalMinutes - (60 * hours);

  String minutesStr = prependZeroIfNeeded('$minutes');

  return '${hours}h ${minutesStr}m';
}
