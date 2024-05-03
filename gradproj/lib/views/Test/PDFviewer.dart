import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFviewer extends StatelessWidget {
  PDFviewer({Key? key, required this.pdfPath}) : super(key: key);  
  final pdfPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: PDFView(
          filePath: pdfPath,
        ),
      ),
    );
  }
}
