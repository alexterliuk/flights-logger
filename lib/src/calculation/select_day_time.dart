import 'package:flutter/material.dart';

const List<String> dayStartOptions = <String>[
  '04:00',
  // '04:30',
  '05:00',
  // '05:30',
  '06:00',
  // '06:30',
  '07:00',
  // '07:30',
  '08:00',
];

const List<String> dayEndOptions = <String>[
  '16:00',
  // '16:30',
  '17:00',
  // '17:30',
  '18:00',
  // '18:30',
  '19:00',
  // '19:30',
  '20:00',
  // '20:30',
  '21:00',
];

typedef MenuEntry = DropdownMenuEntry<String>;

class SelectDayTime extends StatefulWidget {
  const SelectDayTime({
    super.key,
    required this.callback,
  });

  final void Function({ required String dayStart, required String dayEnd }) callback;

  @override
  State<SelectDayTime> createState() => SelectDayTimeState();
}

class SelectDayTimeState extends State<SelectDayTime> {
  String dayStartValue = dayStartMenuEntries.first.value;
  String dayEndValue = dayEndMenuEntries.first.value;

  static final List<MenuEntry> dayStartMenuEntries = (() =>
    dayStartOptions.map((String name) =>
      MenuEntry(value: name, label: name)).toList()
  )();
  static final List<MenuEntry> dayEndMenuEntries = (() =>
    dayEndOptions.map((String name) =>
      MenuEntry(value: name, label: name)).toList()
  )();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Day time'),
        Row(
          children: [
            Column(
              children: [
                const SizedBox(width: 124, child: Text('Day start')),
                DropdownMenu<String>(
                  width: 124,
                  inputDecorationTheme: InputDecorationTheme(border: null),
                  focusNode: FocusNode(canRequestFocus: false),
                  // menuHeight: 100,
                  initialSelection: dayStartMenuEntries.first.label,
                  onSelected: (String? value) {
                    setState(() {
                      dayStartValue = value!;
                      widget.callback(dayStart: dayStartValue, dayEnd: dayEndValue);
                    });
                  },
                  dropdownMenuEntries: dayStartMenuEntries,
                ),
              ],
            ),
            const SizedBox(width: 48),
            Column(
              children: [
                const SizedBox(width: 124, child: Text('Day end')),
                DropdownMenu<String>(
                  width: 124,
                  inputDecorationTheme: InputDecorationTheme(border: null),
                  focusNode: FocusNode(canRequestFocus: false),
                  initialSelection: dayEndMenuEntries.first.label,
                  onSelected: (String? value) {
                    setState(() {
                      dayEndValue = value!;
                      widget.callback(dayStart: dayStartValue, dayEnd: dayEndValue);
                    });
                  },
                  dropdownMenuEntries: dayEndMenuEntries,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
