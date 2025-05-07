import 'package:flutter/material.dart';
import 'flight_logs_loading.dart';

class ShowAllFlights extends StatelessWidget {
  const ShowAllFlights({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void showFlights() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FlightLogsLoading()),
      );
    }

    return TextButton(onPressed: showFlights, child: const Text('Show all flights'));
  }
}
