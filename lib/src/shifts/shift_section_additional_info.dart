import 'package:flutter/material.dart';
import 'shift_model.dart';

class ShiftsSectionAdditionalInfo extends StatelessWidget {
  const ShiftsSectionAdditionalInfo({
    super.key,
    required this.shift,
    required this.isExpanded,
  });

  final ShiftModel shift;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return isExpanded
      ?
        Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 48),
                const SizedBox(
                  width: 180,
                  child: Text(
                    'Longest flight time: ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Text('${shift.longestFlightTimeMinutes} m'),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 48),
                const SizedBox(
                  width: 180,
                  child: Text(
                    'Longest distance: ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Text('${shift.longestDistanceMeters} m'),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 48),
                const SizedBox(
                  width: 180,
                  child: Text(
                    'Highest altitude: ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Text('${shift.highestAltitudeMeters} m'),
                ),
              ],
            ),
          ],
        )
      :
        Container();
  }
}
