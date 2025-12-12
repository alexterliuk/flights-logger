import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../calculation/calculation_result_model.dart';
import '../calculation/make_calculation.dart';
import '../download_data/download_data.dart';
import '../flight_logs/flight_log_model.dart';
import 'utils.dart';
import 'upload_data_model.dart';
import 'uploaded_data_summary.dart';

///
///
///
class UploadData extends StatefulWidget {
  const UploadData({
    super.key,
  });

  Future<dynamic> readJson(FilePickerResult pickerResult) async {
    try {
      PlatformFile file = pickerResult.files.first;
      var fileStr = await file.xFile.readAsString();
      var parsedFile = jsonDecode(fileStr);

      return parsedFile;
    } catch (err) {
      print('[UploadData.readJson] data must be UploadDataModel in json format - $err');
      return UploadDataModel(logs: []);
    }
  }

  Future<FilePickerResult> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    return result ?? FilePickerResult([]);
  }

  @override
  State<UploadData> createState() => UploadDataState();
}

///
///
///
class UploadDataState extends State<UploadData> {
  CalculationResultModel stats = CalculationResultModel();
  List<FlightLogModel> uploadedLogs = [];
  bool isSaving = false;

  Future<void> getAndParseFile() async {
    try {
      final result = await widget.pickFile();
      final parsedFile = await widget.readJson(result);
      final List<FlightLogModel> logs = convertToLogs(parsedFile['logs']);
      final CalculationResultModel calcRes = makeCalculation(logs: logs);

      setState(() {
        stats.flightsCount = calcRes.flightsCount;
        stats.shiftsCount = calcRes.shiftsCount;
        stats.flightsTotalTime = calcRes.flightsTotalTime;
        uploadedLogs = logs;
      });
      // TODO: upload logs to db (with notification that all current data will be deleted)
    } catch (err) {
      print('[UploadData.getAndParseFile] $err');
    }
  }

  Future<void> saveData(List<FlightLogModel> logs) async {
    setState(() {
      isSaving = true;
    });

    var isSuccess = await Future.delayed(const Duration(milliseconds: 2000), () {
      // TODO: process before saving - make data for home, appState, create shifts,
      var shH = createShiftsAndHome(logs);
      // TODO: erase data (via a single responsible function), then save data
      // resetAppState
      // then make redirection to Home
      // In the process call getLastShiftIdFromDb and getLastShiftId?
      return true;
    });

    // TODO: this block is not needed when redirecting to Home is made
    if (isSuccess) {
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          UploadedDataSummary(
            flightsCount: stats.flightsCount,
            shiftsCount: stats.shiftsCount,
            flightsTotalTime: stats.flightsTotalTime,
          ),
          Row(
            children: [const SizedBox(width: 10, height: 30)],
          ),
          Column(
            children: [
              const SizedBox(
                width: 360,
                child: Text(
                  'Save data? This will erase all your current data.'
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 128,
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () { downloadData(); },
                      child: const Text('Download data'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () { saveData(uploadedLogs); },
                      child: const Text('Save'),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [const SizedBox(width: 10, height: 30)],
          ),
          isSaving ? const CircularProgressIndicator() : const SizedBox(),
        ],
      ),
    );
  }
}






// /// wait some milliseconds and call `onProgress`
// /// with different `count` to simulate a progression
// class FakeFileHandler extends FileUploadHandler {
//   FakeFileHandler({required super.file});
//
//   @override
//   Future<void> upload({ProgressCallback? onProgress}) async {
//     final fileLength = await file.length();
//     onProgress?.call(0, fileLength);
//     await Future.delayed(const Duration(milliseconds: 200));
//
//     onProgress?.call(fileLength ~/ 3, fileLength);
//     await Future.delayed(const Duration(milliseconds: 400));
//
//     onProgress?.call((fileLength * 2) ~/ 3, fileLength);
//     await Future.delayed(const Duration(milliseconds: 200));
//
//     onProgress?.call(fileLength, fileLength);
//     return;
//   }
// }
//
// /// The simplest case that uses [FileUploader] and [ProvidedFileCard].
// class DefaultFilesUpload extends StatelessWidget {
//   const DefaultFilesUpload({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // final settings = context.watchSettings();
//
//     return Padding(
//       padding: const EdgeInsets.all(0),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: FileUploader(
//                 limit: 2,
//                 // settings.limit,
//                 hideOnLimit: false,
//                 // settings.hideOnLimit,
//                 // color: settings.color,
//                 builder: (context, ref) {
//                   return ProvidedFileCard(
//                     ref: ref,
//                     content: Text("filename"),
//                   );
//                 },
//                 onPressedAddFiles: () async {
//                   await Future.delayed(const Duration(seconds: 1));
//                   return [createFile()];
//                 },
//                 onFileAdded: (file) async {
//                   await Future.delayed(const Duration(milliseconds: 500));
//                   return FakeFileHandler(
//                     file: file,
//                   );
//                 },
//                 onFileUploaded: (file) {
//                   print("file uploaded ${file.id}");
//                 },
//                 onFileRemoved: (file) {
//                   print("file removed ${file.id}");
//                 },
//                 placeholder: Text("add a file"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






// /// create a [File]
// File createIoFile({
//   String fileName = 'file.txt',
//   int length = 1024,
// }) {
//   final tempDir = Directory.systemTemp.createTempSync();
//   final path = '${tempDir.path}/$fileName';
//   final file = File(path);
//
//   final random = Random();
//   final buffer = List<int>.generate(length, (_) => random.nextInt(256));
//   file.writeAsBytesSync(buffer);
//
//   return file;
// }
//
// /// create an [XFile] using `dart:io`
// XFile createFile({
//   String fileName = 'file.txt',
//   int length = 1024,
// }) {
//   final file = createIoFile(fileName: fileName, length: length);
//   return XFile(file.path);
// }




// Future<void> uploadFile() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//   if (result != null) {
//     PlatformFile file = result.files.first;
//     // Assuming you have the file bytes
//     final fileBytes = file.bytes;
//
//     if (fileBytes != null) {
//       final uploader = EnFileUploader(
//         fileBytes: fileBytes,
//         fileName: file.name!,
//         uploadUrl: 'YOUR_UPLOAD_SERVER_URL', // Replace with your server endpoint
//         // Add any other necessary headers or configurations
//       );
//
//       uploader.upload().listen(
//         (EnFileUploaderEvent event) {
//           if (event is EnFileUploaderProgress) {
//             print('Upload progress: ${event.progress}%');
//           } else if (event is EnFileUploaderComplete) {
//             print('Upload complete!');
//           } else if (event is EnFileUploaderError) {
//             print('Upload error: ${event.error}');
//           }
//         },
//       );
//     }
//   }
// }
//
// FileUploader(
// builder: (context, ref) {
// // for each file a ref is created using the provided `IFileUploadHandler`.
// // Here, a widget for managing file uploads should be inserted.
// // ProvidedFileCard automatically provides complete file management and allows for graphical customization.
// // To manage the upload while creating your own widget, use only FileUploadControllerProvider. For just the UI, use FileCard.
// return ProvidedFileCard(
// ref: ref,
// content: Text("filename"),
// );
// },
// onPressedAddFiles: () async {
// // on tap add a list of files
// },
// onFileAdded: (file) async {
// // for each file added create a custom `IFileUploadHandler`
// },
// onFileUploaded: (file) {
// print("file uploaded ${file.id}");
// },
// onFileRemoved: (file) {
// print("file removed ${file.id}");
// },
// placeholder: Text("add a file"),
// )

// class MyFileUploadHandler extends FileUploadHandler {
//   MyFileUploadHandler({required super.file});
//
//   @override
//   Future<void> upload({ProgressCallback? onProgress}) {
//     // TODO: implement upload
//     // Ex. http.post(url, body: file);
//     print('file - $file');
//     return Future.delayed(const Duration(milliseconds: 1000), () {});
//   }
// }

// final file = File('/home/at/Programming/flights-logger-notes/temp-file.txt');
// MyFileUploadHandler getHandler() {
//   return MyFileUploadHandler(file: file);
// }
//
// final handler = getHandler();
// final controller = FileUploadController(handler);

// controller.upload(); // upload the file
// controller.retry(); // retry the upload
// controller.uploaded // check if the file is uploaded

// class MyBusinessLogic extends ChangeNotifier {
//   MyBusinessLogic({required this.controller});
//
//   factory MyBusinessLogic.handler(FileUploadHandler handler) {
//     return MyBusinessLogic(controller: FileUploadController(handler));
//   }
//
//   final FileUploadController controller;
//   bool _isUploading = false;
//   bool get isUploading => _isUploading;
//
//   void uploadFile() {
//     _isUploading = true;
//     notifyListeners();
//
//     controller.upload(onProgress: (progress, total) {
//       ...
//     });
//
//     ...
//   }
// }





















// import 'package:file_picker/file_picker.dart';

// Future<void> pickFile() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//   if (result != null) {
//     PlatformFile file = result.files.first;
//     print('File path: ${file.path}');
//     print('File name: ${file.name}');
//     print('File size: ${file.size}');
//     // You can now use 'file.path' to access the file for upload
//   } else {
//     // User canceled the picker
//   }
// }
