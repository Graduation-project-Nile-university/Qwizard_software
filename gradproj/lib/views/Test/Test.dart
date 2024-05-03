import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/views/Test/PDFviewer.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;

  void PickFile() async {
setState(() {
        isLoading = true;
      });

        await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      ).then((value) {
        _fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path!);
        //fileToDisplay = File(pickedfile!.path.toString());
        print('File name $_fileName');
        
        });

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
                      PickFile();
                    },
                    child: Text('Pick PDF File'),
                  ),
          ),
          if (pickedfile != null)
            SizedBox(
              height: 300,
              width: 400,
              child: PDFviewer(pdfPath: fileToDisplay),
            ),
        ],
      ),
    );
  }
}
