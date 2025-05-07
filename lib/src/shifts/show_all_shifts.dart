import 'package:flutter/material.dart';
import 'shifts_loading.dart';

class ShowAllShifts extends StatelessWidget {
  const ShowAllShifts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void showShifts() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ShiftsLoading()),
      );
    }

    return TextButton(onPressed: showShifts, child: const Text('Show all shifts'));
  }
}
