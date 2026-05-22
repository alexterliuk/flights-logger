import 'package:flutter/material.dart';

class TopNumbers extends StatelessWidget {
  const TopNumbers({
    super.key,
    required this.topFlightTimeMinutes,
    required this.topDistanceMeters,
    required this.topAltitudeMeters,
    this.isDarkMode = false,
  });

  final int topFlightTimeMinutes;
  final int topDistanceMeters;
  final int topAltitudeMeters;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getNumberCard(
          'Top flight time',
          topFlightTimeMinutes,
          'min',
          isDarkMode: isDarkMode,
        ),
        getNumberCard(
          'Top distance',
          topDistanceMeters,
          'm',
          isDarkMode: isDarkMode,
        ),
        getNumberCard(
          'Top altitude',
          topAltitudeMeters,
          'm',
          isDarkMode: isDarkMode,
        ),
      ],
    );
  }
}

Widget getNumberCard(
  String label,
  int value,
  String unit,
  { bool isDarkMode = false }
) {
  return Container(
    width: 100,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    decoration: BoxDecoration(
      color: isDarkMode ? Colors.white54 : Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border(
        top: BorderSide(color: Colors.black12),
        right: BorderSide(color: Colors.black12),
        bottom: BorderSide(color: Colors.black12),
        left: BorderSide(color: Colors.black12),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.black),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '$value',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.black87 : null,
              ),
            ),
            Text(
              ' $unit',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.black87 : null,
              ),
            ),
          ],
        ),
        // Text(
        //   '$value $unit',
        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        // ),
        const SizedBox(height: 8),
        // Text(
        //   unit,
        //   style: TextStyle(fontSize: 10, color: Colors.grey[500]),
        // )
      ],
    ),
  );
}
