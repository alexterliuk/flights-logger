import 'package:flutter/material.dart';

class ShiftsHeader extends StatelessWidget {
  const ShiftsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Started At',
                textAlign: TextAlign.end,
                style: const TextStyle(height: 2.4),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
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
              padding: const EdgeInsets.all(4.0),
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
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: 70,
                height: 36,
                child: Text(
                  'Total Time',
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
