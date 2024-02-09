import 'package:flutter/material.dart';
import 'package:gradproj/widgets/centeredView/centeredView.dart';
import 'package:gradproj/widgets/navigationBar/navigationBar.dart';


class trialPage extends StatelessWidget {
  const trialPage({Key? key}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: navigationBar(),backgroundColor: Color.fromARGB(255, 141, 4, 141), toolbarHeight: 110,),
      body:centeredView(
      child: Container(
        width: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text(
                "the trial",
                style: TextStyle(fontSize: 21, height: 1.7, color: Colors.purple[800]))
          ],
        ),
      ),),
    );
  }
}