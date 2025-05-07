String getShiftTotalTime(int totalMinutes) {
  if (totalMinutes < 60) {
    return '$totalMinutes m';
  }

  int hours = (totalMinutes / 60).floor();
  int minutes = totalMinutes - (60 * hours);

  String minutesStr = minutes < 10 ? '0$minutes' : '$minutes';

  return '$hours h $minutesStr m';
}
