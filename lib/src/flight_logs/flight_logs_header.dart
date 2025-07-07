import 'package:flutter/material.dart';

class FlightLogsHeader extends StatelessWidget {
  const FlightLogsHeader({
    super.key,
    this.title,
    this.isSingleShiftMode = false,
    this.isLastFlightMode = false,
  });

  final String? title;
  final bool isSingleShiftMode;
  final bool isLastFlightMode;

  @override
  Widget build(BuildContext context) {
    final singleShiftHeader = [ // 368px
      const SizedBox(width: 40, child: Text('#', textAlign: TextAlign.start)),
      const SizedBox(width: 4),
      const SizedBox(width: 64, child: Text('Takeoff', textAlign: TextAlign.end)),
      const SizedBox(width: 8),
      const SizedBox(width: 64, child: Text('Landing', textAlign: TextAlign.end)),
      const SizedBox(width: 8),
      const SizedBox(width: 80, child: Text('Distance', textAlign: TextAlign.end)),
      const SizedBox(width: 12),
      const SizedBox(width: 82, child: Text('Location', textAlign: TextAlign.end)),
      const SizedBox(width: 6),
    ];

    final lastLogHeader = [ // 324px
      const SizedBox(width: 64, child: Text('Takeoff', textAlign: TextAlign.end)),
      const SizedBox(width: 8),
      const SizedBox(width: 64, child: Text('Landing', textAlign: TextAlign.end)),
      const SizedBox(width: 8),
      const SizedBox(width: 80, child: Text('Distance', textAlign: TextAlign.end)),
      const SizedBox(width: 12),
      const SizedBox(width: 82, child: Text('Location', textAlign: TextAlign.end)),
      const SizedBox(width: 6),
    ];

    final allLogsHeader = [ // 328px
      const SizedBox(width: 88, child: Text('Start Date', textAlign: TextAlign.start)),
      const SizedBox(width: 8),
      const SizedBox(width: 64, child: Text('Takeoff', textAlign: TextAlign.end)),
      const SizedBox(width: 8),
      const SizedBox(width: 64, child: Text('Landing', textAlign: TextAlign.end)),
      const SizedBox(width: 8),
      const SizedBox(width: 80, child: Text('Distance', textAlign: TextAlign.end)),
      const SizedBox(width: 8),
    ];

    var header = allLogsHeader;
    if (isSingleShiftMode) {
      header = singleShiftHeader;
    } else if (isLastFlightMode) {
      header = lastLogHeader;
    }

    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: header,
            ),
          ],
        ),
      ],
    );
  }
}
