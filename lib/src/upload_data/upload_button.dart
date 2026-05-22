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

    return ElevatedButton(
      onPressed: showUploadData,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        elevation: 8,
        shadowColor: Colors.indigo.withValues(alpha: 0.5),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Upload data',
        style: TextStyle(
          // color: Colors.black87
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
