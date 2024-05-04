import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gradproj/views/home/drwr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/bloc/states.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';

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
      appBar: AppBar(
        title: QuizardCubit.USERTOKEN == null
            ? Text("")
            : Text("Welcome, ${QuizardCubit.USERNAME}"),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
      ),
      drawer: const Drwr(),
      body: centeredView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: isLoading
                    ? CircularProgressIndicator()
                    : TextButton(
                        onPressed: () {
                          pickFile();
                        },
                        child: Text(
                          pickedFileBytes != null ? 'Change File' : 'Pick PDF File',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 20),
            if (pickedFileBytes != null)
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
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
              ),
            SizedBox(height: 20),
            Visibility(
              visible: isPdfRead,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Generate'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
