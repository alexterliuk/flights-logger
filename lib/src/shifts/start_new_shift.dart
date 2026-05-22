import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import 'new_shift.dart';

class StartNewShift extends StatelessWidget {
  const StartNewShift({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    void startShift() async {
      appState.addToHistory(NewShift.routeName);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewShift()),
      );
    }

    return ElevatedButton(
      onPressed: startShift,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        elevation: 8,
        shadowColor: Colors.indigo.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'New shift',
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
