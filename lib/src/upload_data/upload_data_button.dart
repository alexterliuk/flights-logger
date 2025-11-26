import 'package:flutter/material.dart';
import 'upload_data.dart';

class UploadDataButton extends StatelessWidget {
  const UploadDataButton({
    super.key,
  });

  static const routeName = '/upload_data';

  @override
  Widget build(BuildContext context) {
    void showUploadData() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UploadData()),
      );
    }

    return TextButton(onPressed: showUploadData, child: const Text('Upload data'));
  }
}
