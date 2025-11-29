import 'package:flutter/material.dart';

import '../calculation/select_day_time.dart';
import 'calculation_result_model.dart';
import 'make_calculation.dart';
import 'default_vars.dart';

class CalculateData extends StatefulWidget {
  const CalculateData({
    super.key,
  });

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

    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            TextButton(
              onPressed: calculate,
              child: const Text('Calculate'),
            ),
            SelectDayTime(callback: defineDayTime),
            const SizedBox(height: 16),
            isCalculationInProcess
              ? const CircularProgressIndicator()
              : Column(children: [
                  Row(
                    children: [
                      const SizedBox(width: 120, child: Text('Total shifts:')),
                      SizedBox(width: 176, child: Text('${calc.shiftsCount}')),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 120, child: Text('Total flights:')),
                      SizedBox(width: 56, child: Text('${calc.flightsCount}')),
                      SizedBox(width: 120, child: Text(calc.flightsTotalTime)),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 120, child: Text('At night:')),
                      SizedBox(width: 56, child: Text('${calc.flightsAtNightCount}')),
                      SizedBox(width: 120, child: Text(calc.flightsAtNightTotalTime)),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 120, child: Text('At day:')),
                      SizedBox(width: 56, child: Text('${calc.flightsAtDayCount}')),
                      SizedBox(width: 120, child: Text(calc.flightsAtDayTotalTime)),
                    ],
                  ),
            ]),
          ],
        ),
      ],
    );
  }
}
