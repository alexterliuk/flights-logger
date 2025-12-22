import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../utils/date_time/get_date_string_without_time.dart';
import '../utils/date_time/get_time.dart';
import '../db/queries.dart';
import '../flight_logs/flight_log_model.dart';

Future<bool> downloadData() async {
  var hasDownloaded = await Future.delayed(const Duration(milliseconds: 2000), () async {
    final List<FlightLogModel> logs = await getFlightLogsFromDb(limit: 9999);

    print('downloaded logs count - ${logs.length}');

    if (logs.isNotEmpty) {
      await writeLogsToFile(logs);
      return true;
    } else {
      return false;
    }
  });

  return hasDownloaded;
}

Future<File> getLocalFile(String? name) async {
  final directory = await getApplicationDocumentsDirectory();
  final fileName = '${directory.path}/${name ?? 'data'}.txt';

  return File(fileName);
}

Future<void> writeLogsToFile(List<FlightLogModel> logs) async {
  final createdAt = DateTime.now().toIso8601String();
  final date = getDateStringWithoutTimeFromDateString(createdAt);
  final time = getTime(createdAt).replaceFirst(RegExp(r':'), '-');
  final name = 'flight-logs_${date}_$time';

  final file = await getLocalFile(name);
  final logMaps = [];

  for (final log in logs) {
    logMaps.add(log.toMapWithId());
  }

  final dataJson = json.encode({ 'logs': logMaps, 'createdAt': createdAt });

  await file.writeAsString(dataJson);
}
