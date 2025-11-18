import 'package:flutter/material.dart';

const List<String> dayStartOptions = <String>[
  '04:00',
  '05:00',
  '06:00',
  '07:00',
  '08:00',
];

const List<String> dayEndOptions = <String>[
  '16:00',
  '17:00',
  '18:00',
  '19:00',
  '20:00',
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
  String initialDayStartSelection = dayStartMenuEntries.first.label;

  String dayEndValue = dayEndMenuEntries.first.value;
  String initialDayEndSelection = dayEndMenuEntries.first.label;

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
                  initialSelection: initialDayStartSelection,
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
                  initialSelection: initialDayEndSelection,
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
