import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import '../shifts/shifts_loading.dart';
import '../calendar/calendar_period.dart';
import '../calculation/select_day_time.dart';
import '../utils/date_time/from_date_time.dart';
import 'calculation_result_model.dart';
import 'make_calculation.dart';

class CalculateData extends StatefulWidget {
  const CalculateData({
    super.key,
  });

  @override
  State<CalculateData> createState() => CalculateDataState();
}

class CalculateDataState extends State<CalculateData> {
  String dayStartsAt = dayStartOptions.first;
  String dayEndsAt = dayEndOptions.last;
  DateTime fromTheDate = DateTime(2000);
  DateTime toTheDate = DateTime(2100);

  bool isCalculationInProcess = false;
  CalculationResultModel calc = CalculationResultModel();

  void calculate({ required DateTime fromDate, required DateTime toDate }) async {
    setState(() {
      fromTheDate = fromDate;
      toTheDate = toDate;
      isCalculationInProcess = true;
    });
    // print('calculate: fromTheDate - ${fromTheDate.toString()}, toTheDate - ${toTheDate.toString()}');
    // print('calculate: dayStartsAt - $dayStartsAt, dayEndsAt - $dayEndsAt');
    Navigator.pop(context);

    var calcRes = await makeCalculation(
      fromDate: fromDate,
      toDate: toDate,
      dayStartsAt: dayStartsAt,
      dayEndsAt: dayEndsAt,
    );

    print('calcRes is ${calcRes.toMap()}');
    setState(() {
      calc = calcRes;
      isCalculationInProcess = false;
    });
  }

  void defineDayTime({ required String dayStart, required String dayEnd }) {
    setState(() {
      dayStartsAt = dayStart;
      dayEndsAt = dayEnd;
    });
    // print('defineDayTime: fromTheDate - ${fromTheDate.toString()}, toTheDate - ${toTheDate.toString()}');
    // print('defineDayTime: dayStartsAt - $dayStartsAt, dayEndsAt - $dayEndsAt');
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                    CalendarPeriod(callback: calculate),
                  ),
                );
              },
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
