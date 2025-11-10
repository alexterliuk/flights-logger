/// time - 'HH:mm'
double timeToDouble (String time) {
  try {
    double timeDouble = double.parse(
      time.replaceFirst(RegExp(r':'), '.')
    );

    return timeDouble;
  } catch (e) {
    return -1;
  }
}
