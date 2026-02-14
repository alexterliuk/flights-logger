import 'package:flutter/material.dart';
import '../utils/get_total_time.dart';
import 'shift_model.dart';

class ShiftsSectionMainInfo extends StatelessWidget {
  const ShiftsSectionMainInfo({
    super.key,
    required this.shift,
    required this.index,
    required this.isEditButtonShown,
    required this.edit,
  });

  final ShiftModel shift;
  final int index;
  final bool isEditButtonShown;
  final Null Function() edit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '${index + 1}',
            textAlign: TextAlign.start,
            style: const TextStyle(height: 2.4),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            shift.startedAtDateAndTime.isEmpty
              ? 'none'
              : shift.startedAtDateAndTime.substring(0, 10),
            textAlign: TextAlign.end,
            style: const TextStyle(height: 2.4),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            shift.endedAtDateAndTime.isEmpty
              ? 'none'
              : shift.endedAtDateAndTime.substring(0, 10),
            textAlign: TextAlign.end,
            style: const TextStyle(height: 2.4),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${shift.flightsQty}',
            textAlign: TextAlign.end,
            style: const TextStyle(height: 2.4),
          ),
        ),
        Expanded(
          flex: 2,
          child: isEditButtonShown
            ?
              SizedBox(
                width: 70,
                height: 38,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: edit,
                      iconSize: 18,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              )
            :
              SizedBox(
                width: 70,
                height: 38,
                child: Text(
                  getTotalTime(shift.timeTotalMinutes + 600),
                  textAlign: TextAlign.end,
                  style: const TextStyle(height: 2.4),
                ),
              ),
        ),
      ],
    );
  }
}
