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
                isOrdinalShown ? const SizedBox(width: 30, child: Text('#')) : Container(),
                const SizedBox(width: 65, child: Text('Takeoff')),
                const SizedBox(width: 65, child: Text('Landing')),
                const SizedBox(width: 90, child: Text('Distance')),
                const SizedBox(width: 70, child: Text('Location')),
                const SizedBox(width: 6),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
