import 'package:flutter/material.dart';
import 'upload.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
  });

  static const routeName = '/upload';

  @override
  Widget build(BuildContext context) {
    void showUploadData() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Upload()),
      );
    }

    return TextButton(onPressed: showUploadData, child: const Text('Upload data'));
  }
}
