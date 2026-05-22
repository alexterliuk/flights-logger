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

    return ElevatedButton(
      onPressed: showFlights,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        elevation: 8,
        shadowColor: Colors.indigo.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'All flights',
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
