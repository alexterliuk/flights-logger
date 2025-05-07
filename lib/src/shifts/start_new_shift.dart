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

    void onPressed() async {
      appState.addToHistory(NewShift.routeName);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewShift()),
      );
    }

    return TextButton(onPressed: onPressed, child: const Text('New shift'));
  }
}
