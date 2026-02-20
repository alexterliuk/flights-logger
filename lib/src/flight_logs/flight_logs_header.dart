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

    final singleShiftHeader = [
      Expanded(
        flex: 3,
        child: Text(
          '#',
          textAlign: TextAlign.start,
          style: const TextStyle(height: 2.4),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          'Takeoff',
          textAlign: TextAlign.end,
          style: const TextStyle(height: 2.4),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          'Landing',
          textAlign: TextAlign.end,
          style: const TextStyle(height: 2.4),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          'Distance',
          textAlign: TextAlign.end,
          style: const TextStyle(height: 2.4),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          'Location',
          textAlign: TextAlign.end,
          style: const TextStyle(height: 2.4),
        ),
      ),
    ];

    final allLogsHeader = [
      Expanded(
        flex: 2,
        child: Text(
          'Start Date',
          textAlign: TextAlign.start,
          style: const TextStyle(height: 2.4),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          'Takeoff',
          textAlign: TextAlign.end,
          style: const TextStyle(height: 2.4),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          'Landing',
          textAlign: TextAlign.end,
          style: const TextStyle(height: 2.4),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          'Distance',
          textAlign: TextAlign.end,
          style: const TextStyle(height: 2.4),
        ),
      ),
    ];

    List<Widget> header = allLogsHeader;
    if (isSingleShiftMode) {
      header = singleShiftHeader;
    } else if (isLastFlightMode) {
      header = lastLogHeader;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: isLastFlightMode ? MainAxisSize.min : MainAxisSize.max,
        children: header,
      ),
    );
  }
}
