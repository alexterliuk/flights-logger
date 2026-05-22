import 'package:flutter/material.dart';
import 'calculate_data.dart';

class GetStats extends StatelessWidget {
  const GetStats({
    super.key,
  });

  static const routeName = '/get_stats';

  @override
  Widget build(BuildContext context) {
    void getStats() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CalculateData()),
      );
    }

    return ElevatedButton(
      onPressed: getStats,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        elevation: 8,
        shadowColor: Colors.indigo.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Get stats',
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
