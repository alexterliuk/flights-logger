import 'package:flutter/material.dart';
import '../utils/gaps.dart';
import 'default_vars.dart';

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
        const Text(
          'Day time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const Gap12(),
        Row(
          children: [
            Column(
              children: [
                const SizedBox(
                  width: 124,
                  child: Text(
                    'Day start',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
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
                const SizedBox(
                  width: 124,
                  child: Text(
                    'Day end',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
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
