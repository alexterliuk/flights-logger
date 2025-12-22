import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'upload_model.dart';

Future<dynamic> readJson(FilePickerResult pickerResult) async {
  try {
    PlatformFile file = pickerResult.files.first;
    var fileStr = await file.xFile.readAsString();
    var parsedFile = jsonDecode(fileStr);

    return parsedFile;
  } catch (err) {
    print('[readJson] data must be UploadModel in json format - $err');
    return UploadModel(logs: []);
  }
}

Future<FilePickerResult> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
  );

  return result ?? FilePickerResult([]);
}
