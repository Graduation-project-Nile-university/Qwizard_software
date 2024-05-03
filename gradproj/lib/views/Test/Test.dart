import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Uint8List? pickedFileBytes;
  String? _fileName;
  int? _fileSize;
  bool isLoading = false;
  bool isPdfRead = false;

  void pickFile() async {
    setState(() {
      isLoading = true;
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      pickedFileBytes = result.files.first.bytes;
      _fileName = result.files.first.name;
      _fileSize = result.files.first.size;
      print('The PDF is open successfully');
      setState(() {
        isPdfRead = true;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: isLoading
                ? CircularProgressIndicator()
                : TextButton(
                    onPressed: () {
                      pickFile();
                    },
                    child: Text('Pick PDF File'),
                  ),
          ),
          if (pickedFileBytes != null)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'File Name: $_fileName',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'File Size: ${(_fileSize! / 1024).toStringAsFixed(2)} KB',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          Visibility(
            visible: isPdfRead,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  print('Generate button clicked');
                },
                child: Text('Generate'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
