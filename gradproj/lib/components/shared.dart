import 'package:flutter/material.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';

String BASEURL = "http://192.168.1.6:8000";

ThemeData themeData = ThemeData(primaryColor: Color.fromARGB(255, 141, 4, 141));

extension ImageFromAsset on String {
  String imageAssetPng() {
    return "assets/$this.png";
  }

  String imageAssetJPEG() {
    return "assets/$this.jpeg";
  }
}

AppBar quizardAppBar(BuildContext context) {
  var screenWidth = MediaQuery.of(context).size.width;
  return AppBar(
    title: screenWidth > 800
        ? navigationBar()
        : Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
              child: Image.asset(
                'quizard'.imageAssetPng(),
                width: 100,
              ),
            ),
          ),
    backgroundColor: Color.fromARGB(255, 141, 4, 141),
    toolbarHeight: 110,
  );
}
