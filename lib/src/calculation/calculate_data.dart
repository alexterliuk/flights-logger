import 'package:flutter/material.dart';

import '../calculation/select_day_time.dart';
import '../settings/settings_view.dart';
import '../utils/gaps.dart';
import 'calculation_result_model.dart';
import 'make_calculation.dart';
import 'default_vars.dart';

class CalculateData extends StatefulWidget {
  const CalculateData({
    super.key,
    this.isAppBarShown = true,
  });

  final bool isAppBarShown;

  @override
  State<CalculateData> createState() => CalculateDataState();
}

class CalculateDataState extends State<CalculateData> {
  // initial value for dayStartsAt, dayEndsAt should be same as
  // dayStartValue, dayEndValue in SelectDayTime
  String dayStartsAt = dayStartOptions.first;
  String dayEndsAt = dayEndOptions.first;
  DateTime fromDate = defaultFromYearDateTime;
  DateTime toDate = defaultToYearDateTime;

  bool isCalculationInProcess = false;
  CalculationResultModel calc = CalculationResultModel();

  void calculate() async {
    DateTimeRange<DateTime>? range = await showDateRangePicker(
      context: context,
      firstDate: fromDate,
      lastDate: toDate,
    );

    setState(() {
      if (range is DateTimeRange) {
        fromDate = range.start;
        toDate = range.end;
        isCalculationInProcess = true;
      }
    });

    CalculationResultModel calcRes = calc;
    if (fromDate.year != defaultFromYear) {
      calcRes = await getDataFromDbAndMakeCalculation(
        fromDate: fromDate,
        toDate: toDate,
        dayStartsAt: dayStartsAt,
        dayEndsAt: dayEndsAt,
      );
    }

    setState(() {
      calc = calcRes;
      isCalculationInProcess = false;
      fromDate = DateTime(defaultFromYear);
      toDate = DateTime(defaultToYear);
    });
  }

  void defineDayTime({ required String dayStart, required String dayEnd }) {
    setState(() {
      dayStartsAt = dayStart;
      dayEndsAt = dayEnd;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: widget.isAppBarShown
        ? AppBar(
            // automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: const Text('Calculate data'),
            // title: Row(
            //   children: [
            //     BackButton(
            //       onPressed: onPressBackButton,
            //       style: const ButtonStyle(
            //         padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
            //       ),
            //     ),
            //     const Padding(padding: EdgeInsets.all(8)),
            //     const Text('Calculate data'),
            //   ],
            // ),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.restorablePushNamed(context, SettingsView.routeName);
                },
              ),
            ],
          )
        : null,
      body: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              ElevatedButton(
                onPressed: calculate,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.indigo,
                  elevation: 8,
                  shadowColor: Colors.indigo.withValues(alpha: 0.5),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                    // color: Colors.black87
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              // TextButton(
              //   onPressed: calculate,
              //   child: const Text('Calculate'),
              // ),
              const Gap12(),
              SelectDayTime(callback: defineDayTime),
              const Gap24(),
              isCalculationInProcess
                ? const CircularProgressIndicator()
                : Column(children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 120,
                          child: Text(
                            'Total shifts:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 176,
                          child: Text(
                            '${calc.shiftsCount}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 120,
                          child: Text(
                            'Total flights:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 56,
                          child: Text(
                            '${calc.flightsCount}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            calc.flightsTotalTime,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 120,
                          child: Text(
                            'At night:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 56,
                          child: Text(
                            '${calc.flightsAtNightCount}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            calc.flightsAtNightTotalTime,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 120,
                          child: Text(
                            'At day:',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 56,
                          child: Text(
                            '${calc.flightsAtDayCount}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            calc.flightsAtDayTotalTime,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
