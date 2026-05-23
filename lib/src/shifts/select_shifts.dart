import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../shifts/shifts_loading.dart';
import '../calendar/calendar_period.dart';

class SelectShifts extends StatelessWidget {
  const SelectShifts({
    super.key,
  });

  static const routeName = '/select-shifts';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    void showShifts({ required DateTime fromDate, required DateTime toDate }) {
      appState.setSelectedShiftsMode(fromDate, toDate);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
          ShiftsLoading(fromDate: fromDate, toDate: toDate),
        ),
      );
    }

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
            CalendarPeriod(callback: showShifts),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo, // !!!
        elevation: 8,
        shadowColor: Colors.indigo.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Select shifts',
        style: TextStyle(
          // color: Colors.black87
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
