import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../db/queries.dart';
import '../calculation/calculation_result_model.dart';
import '../calculation/make_calculation.dart';
import '../download_data/download_data.dart';
import '../flight_logs/flight_log_model.dart';
import '../app_state_utils.dart';
import '../home/home.dart';
import 'utils.dart';
import 'upload_data.dart';
import 'upload_summary.dart';

class Upload extends StatefulWidget {
  const Upload({
    super.key,
  });

  @override
  State<Upload> createState() => UploadState();
}

class UploadState extends State<Upload> {
  CalculationResultModel stats = CalculationResultModel();
  List<FlightLogModel> uploadedLogs = [];
  bool isSaving = false;
  bool isSavingEnabled = false;
  bool isDownloading = false;

  Future<void> getAndParseFile() async {
    try {
      final result = await pickFile();
      final parsedFile = await readJson(result);
      final List<FlightLogModel> logs = convertToLogs(parsedFile['logs']);
      final CalculationResultModel calcRes = makeCalculation(logs: logs);

      setState(() {
        stats.flightsCount = calcRes.flightsCount;
        stats.shiftsCount = calcRes.shiftsCount;
        stats.flightsTotalTime = calcRes.flightsTotalTime;

        if (logs.isNotEmpty) {
          uploadedLogs = logs;
          isSavingEnabled = true;
        }
      });

    } catch (err) {
      print('[Upload.getAndParseFile] $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    void redirectToHome() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }

    Future<void> saveUploadedLogs() async {
      setState(() {
        isSaving = true;
      });
      await save(uploadedLogs);
      resetAppState(appState);
      redirectToHome();
    }

    Future<void> downloadExistingLogs() async {
      setState(() {
        isDownloading = true;
      });
      await downloadData();
      setState(() {
        isDownloading = false;
      });
    }

    Widget showSaveAndDownloadButtons() {
      return Column(
        children: [
          SizedBox(
            width: 360,
            child: Text(
              'Save uploaded data? This will erase all your current data. If you want to keep your data, first click "Download data"',
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 56,
            child: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: saveUploadedLogs,
              // backgroundColor: isSavingEnabled ? null : Colors.transparent,
              // elevation: isSavingEnabled ? null : 0,
              child: Text(
                'Save',
                // style: TextStyle(
                //   color: isSavingEnabled ? null : Colors.transparent,
                // ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 360,
            child: Text(
              'You can download your data, and upload it to the app again later if you need.'
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 128,
            child: FloatingActionButton(
              heroTag: null,
              mini: true,
              onPressed: downloadExistingLogs,
              child: isDownloading
                ? const CircularProgressIndicator()
                : const Text('Download data'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // titleSpacing: 0,
        title: const Text('Uploaded data'),
        // title: Row(
        //   children: [
        //     BackButton(
        //       onPressed: onPressBackButton,
        //       style: const ButtonStyle(
        //         padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        //       ),
        //     ),
        //     const Padding(padding: EdgeInsets.all(8)),
        //     const Text('Uploaded data'),
        //   ],
        // ),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: getAndParseFile,
            icon: const Icon(Icons.add_chart),
          ),
          UploadSummary(
            flightsCount: stats.flightsCount,
            shiftsCount: stats.shiftsCount,
            flightsTotalTime: stats.flightsTotalTime,
          ),
          const SizedBox(height: 24),
          isSavingEnabled ? showSaveAndDownloadButtons() : const SizedBox(),
          const SizedBox(height: 16),
          isSaving ? const CircularProgressIndicator() : const SizedBox(),
        ],
      ),
    );
  }
}
