import 'package:flutter/material.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/widgets/homeBody/homeBody.dart';
import 'package:gradproj/widgets/trial/trial.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: navigationBar(),
        backgroundColor: Color.fromARGB(255, 141, 4, 141),
        toolbarHeight: 110,
      ),
      backgroundColor: const Color.fromARGB(1, 1, 1, 1),
      body: centeredView(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Row(
              children: <Widget>[
                homeBody(),
                Center(
                  child: trial("  Try me  "),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
