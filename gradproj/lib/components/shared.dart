import 'package:flutter/material.dart';
import 'package:gradproj/bloc/cubit.dart';
import 'package:gradproj/views/home/HomeView.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';
import 'package:lottie/lottie.dart';

String BASEURL = "http://192.168.1.6:8000";
Uri? navigatedURL;

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
    actions: [
      QuizardCubit.USERTOKEN != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                    QuizardCubit.MEMBERSHIP == "PRO" ||
                            QuizardCubit.MEMBERSHIP == "Q-PRO"
                        ? "assets/active.json"
                        : QuizardCubit.NUMBEROFGENS > 0
                            ? "assets/active.json"
                            : "assets/dead.json",
                    width: 40),
                Text(
                  QuizardCubit.MEMBERSHIP == "PRO" ||
                          QuizardCubit.MEMBERSHIP == "Q-PRO"
                      ? "∞ Exams"
                      : "${QuizardCubit.NUMBEROFGENS} ${QuizardCubit.NUMBEROFGENS == 1 ? "Exam" : "Exams"} left ",
                  style: TextStyle(
                      color: QuizardCubit.MEMBERSHIP == "PRO" ||
                              QuizardCubit.MEMBERSHIP == "Q-PRO"
                          ? Colors.white
                          : QuizardCubit.NUMBEROFGENS > 0
                              ? Colors.white
                              : Colors.red),
                )
              ],
            )
          : Container()
    ],
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
                width: 140,
              ),
            ),
          ),
    backgroundColor: Color.fromARGB(255, 141, 4, 141),
    toolbarHeight: 110,
  );
}
