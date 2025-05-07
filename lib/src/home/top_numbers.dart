import 'package:flutter/material.dart';

class TopNumbers extends StatelessWidget {
  const TopNumbers({
    super.key,
    required this.topFlightTimeMinutes,
    required this.topDistanceMeters,
    required this.topAltitudeMeters,
  });

  final int topFlightTimeMinutes;
  final int topDistanceMeters;
  final int topAltitudeMeters;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Top flight time:')),
                SizedBox(width: 176, child: Text('$topFlightTimeMinutes')),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Top distance:')),
                SizedBox(width: 176, child: Text('$topDistanceMeters')),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Top altitude:')),
                SizedBox(width: 176, child: Text('$topAltitudeMeters')),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
