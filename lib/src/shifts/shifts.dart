import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/queries.dart';
import '../home/home.dart';
import '../settings/settings_view.dart';
import '../app_state.dart';
import './shift_model.dart';
import './shift.dart';
import '../utils/table_methods.dart';
import 'shifts_header.dart';

class ShiftsTitle extends StatelessWidget {
  const ShiftsTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Text('Shifts - ${appState.shiftsRes.totalCount} items');
  }
}

class ShiftsState extends TableMethods {}

class Shifts extends StatelessWidget {
  const Shifts({
    super.key,
    this.title,
    this.isAppBarShown = true,
    this.fromDate,
    this.toDate,
  });

  final String? title;
  final bool isAppBarShown;
  final DateTime? fromDate;
  final DateTime? toDate;

  static const routeName = '/shifts';

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    appState.updateCurrentPage(Shifts.routeName);
    appState.addToHistory(Shifts.routeName);

    final List<ShiftModel> shifts = appState.shiftsRes.shifts;
    final int shiftsTotalCount = appState.shiftsRes.totalCount;

    void getMoreShifts(int offset) async {
      ShiftsResult shiftsResult = await getShiftsFromDb(
        offset: offset,
        fromDate: fromDate,
        toDate: toDate,
      );
      List<ShiftModel> moreShifts = shiftsResult.shifts;

      if (moreShifts.isNotEmpty) {
        appState.updateShiftsRes(shiftsResult);
        appState.update();
      }      
    }

    void onPressBackButton() async {
      appState.removeFromHistory(Shifts.routeName);
      appState.resetShifts();

      if (appState.isSelectedShiftsMode) {
        appState.resetSelectedShiftsMode();
      }

      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      Navigator.push(context,
        MaterialPageRoute(builder: (context) => const Home(
          isInitLoading: false,
        )),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => ShiftsState(),
      child: Scaffold(
        appBar: isAppBarShown
          ? AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Row(
                children: [
                  BackButton(
                    onPressed: onPressBackButton,
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Text(title ?? 'Shifts'),
                ],
              ),
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
        body: Column(
          children: [
            const ShiftsHeader(),
            Flexible(
              child:
                ListView.builder(
                  restorationId: 'shifts',
                  itemCount: shifts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final shift = shifts[index];
                    if (index == shifts.length - 1) {
                      print('...loading more shifts index $index, id: ${shift.id}, shifts.length: ${shifts.length}');
                      getMoreShifts(shifts.length);
                    }

                    return Shift(shift: shift, index: index);
                  },
                ),
            ),
          ],
        ),
      ),
    );
  }
}
