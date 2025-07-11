import 'package:flights_logger/src/db/queries.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import 'flight_log_model.dart';
import 'flight_logs.dart';

typedef FlightLogsLoadingArguments = Map<String, Object>;

class FlightLogsLoading extends StatefulWidget {
  final bool isLoadByIds;
  final List<int> ids;
  final List<int> idsForReload;

  const FlightLogsLoading({
    super.key,
    this.isLoadByIds = false,
    this.ids = const [],
    this.idsForReload = const [],
  });

  static const routeName = '/flight_logs_loading';

  @override
  State<FlightLogsLoading> createState() =>
      FlightLogsLoadingState();
}

class FlightLogsLoadingState extends State<FlightLogsLoading> {
  Future<List<FlightLogModel>>? logs;

  @override
  void initState() {
    /// 0
    print('     [FlightLogsLoading.initState]');
    super.initState();
    loadLogs();
  }

  void loadLogs() async {
    /// 1
    print('     [FlightLogsLoading.loadLogs]');
    Future<List<FlightLogModel>> loadedLogs = widget.isLoadByIds
      ? getFlightLogsByIdsFromDb(ids: widget.ids)
      : getFlightLogsFromDb(offset: 0, limit: 20);

    // await Future<void>.delayed(const Duration(seconds: 3));

    setState(() {
      logs = loadedLogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 2
    var appState = context.watch<MyAppState>();

    return FutureBuilder(
      future: logs,
      builder:(context, AsyncSnapshot<List<FlightLogModel>> snapshot) {
        if (snapshot.hasData) {
          appState.addToHistory(FlightLogs.routeName);

          widget.isLoadByIds
            ? appState.updateSingleShiftFlightLogs(
                givenLogs: snapshot.data ?? [],
                idsForReload: widget.idsForReload,
            )
            : appState.updateFlightLogs(
                givenLogs: snapshot.data ?? [],
                idsForReload:  widget.idsForReload,
            );

          return FlightLogs();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Flight logs'),
            ),

            body: const Center(
              // widthFactor: 10,
              heightFactor: 10,
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
  }
}
