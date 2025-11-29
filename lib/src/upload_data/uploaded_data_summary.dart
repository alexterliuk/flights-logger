import 'package:flutter/material.dart';

class UploadedDataSummary extends StatelessWidget {
  const UploadedDataSummary({
    super.key,
    this.flightsCount = 0,
    this.shiftsCount = 0,
    this.flightsTotalTime = '',
  });

  final int flightsCount;
  final int shiftsCount;
  final String flightsTotalTime;

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
                const SizedBox(width: 120, child: Text('Flights count:')),
                SizedBox(width: 176, child: Text('$flightsCount')),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Shifts count:')),
                SizedBox(width: 176, child: Text('$shiftsCount')),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Total flight time:')),
                SizedBox(width: 176, child: Text(flightsTotalTime)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
