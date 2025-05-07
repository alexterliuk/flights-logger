import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

/// Tell
/// about
/// storage
class MyAppStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print('path: $path');

    return File('$path/logging.txt');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return empty string
      return '';
    }
  }

  Future<File> write(String text) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(text);
  }
}
