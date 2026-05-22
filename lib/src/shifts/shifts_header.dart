import 'package:flutter/material.dart';

class ShiftsHeader extends StatelessWidget {
  const ShiftsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '#',
              textAlign: TextAlign.start,
              style: const TextStyle(height: 2.4),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'Started At',
                textAlign: TextAlign.end,
                style: const TextStyle(height: 2.4),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: const SizedBox(width: 8),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'Ended At',
                textAlign: TextAlign.end,
                style: const TextStyle(height: 2.4),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'Flights',
                textAlign: TextAlign.end,
                style: const TextStyle(height: 2.4),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: 70,
                height: 36,
                child: Text(
                  'Time Total',
                  textAlign: TextAlign.end,
                  style: const TextStyle(height: 2.4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
