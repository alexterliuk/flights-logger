import 'package:flutter/material.dart';

class FlightLogsHeader extends StatelessWidget {
  const FlightLogsHeader({
    super.key,
    this.title,
    this.isOrdinalShown = true,
  });

  final String? title;
  final bool isOrdinalShown;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                SizedBox(width: 32, child: isOrdinalShown ? Text('#') : null),
                const SizedBox(width: 64, child: Text('Takeoff', textAlign: TextAlign.right)),
                const SizedBox(width: 64, child: Text('Landing', textAlign: TextAlign.right)),
                const SizedBox(width: 80, child: Text('Distance', textAlign: TextAlign.right)),
                const SizedBox(width: 80, child: Text('Location', textAlign: TextAlign.right)),
                // const SizedBox(width: 6),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
