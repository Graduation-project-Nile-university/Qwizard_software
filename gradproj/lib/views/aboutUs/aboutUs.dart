import 'package:flutter/material.dart';

class aboutUs extends StatelessWidget {
  const aboutUs({Key? key}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "ehna gamden awy",
            style: TextStyle(fontWeight: FontWeight.w800, height: 0.9, fontSize: 80, color: Colors.purple[800]),
            ),
        ],
      ),
    );
  }
}