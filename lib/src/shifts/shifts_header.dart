import 'package:flutter/material.dart';

class ShiftsHeader extends StatelessWidget {
  const ShiftsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shiftsHeader = [ // 368px
      SizedBox(width: 40, child: Text('#', textAlign: TextAlign.start)),
      SizedBox(width: 4),
      SizedBox(width: 88, child: Text('Started At', textAlign: TextAlign.start)),
      SizedBox(width: 8),
      SizedBox(width: 88, child: Text('Ended At', textAlign: TextAlign.start)),
      SizedBox(width: 8),
      SizedBox(width: 48, child: Text('Flights', textAlign: TextAlign.start)),
      SizedBox(width: 8),
      SizedBox(width: 70, child: Text('Total Time', textAlign: TextAlign.start)),
      SizedBox(width: 6),
    ];

    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: shiftsHeader,
            ),
          ],
        ),
      ],
    );
  }
}
