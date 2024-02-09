import 'package:flutter/material.dart';
import 'package:gradproj/views/trialPage/trialPage.dart';

class trial extends StatelessWidget {
  final String title;
  trial(this.title) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(color: Colors.purple[800],
          borderRadius: BorderRadius.circular(10)),
          child: 
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>trialPage()));},
             child: 
             Text(
             title,
              style: TextStyle(
              fontSize: 45, 
              fontWeight: FontWeight.w800, 
              color: Colors.white),
              ),
              ),
        )
      ],)
    );
  }
}


