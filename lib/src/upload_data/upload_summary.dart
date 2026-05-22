import 'package:flutter/material.dart';

class UploadSummary extends StatelessWidget {
  const UploadSummary({
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
                const SizedBox(
                  width: 140,
                  child: Text(
                    'Flights count:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 156,
                  child: Text(
                    '$flightsCount',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 140,
                  child: Text(
                    'Shifts count:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 156,
                  child: Text(
                    '$shiftsCount',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 140,
                  child: Text(
                    'Total flight time:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 156,
                  child: Text(
                    flightsTotalTime,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
